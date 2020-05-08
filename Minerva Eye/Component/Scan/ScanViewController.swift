//
//  ScanViewController.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import AVFoundation
import CoreData
import SwiftUI
import UIKit

final class ScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var managedObjectContext: NSManagedObjectContext
    
    // FIXME: This is per view! Should be computed or inferred!
    private var cache: [String: BookItem] = [:]
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var boundsView: UIView?
        
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        super.init(nibName: nil, bundle: nil)
   }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blue
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [
                .qr,
                .ean13,
                .code128
            ]
            
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        // previewLayer.frame = CGRect(x: 20, y: 60, width: 335, height: 200)
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
        
        // Initialize QR Code Frame to highlight the QR code
        boundsView = UIView()
        
        if let qrCodeFrameView = boundsView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
        }
    }
    
    func failed() {
        let ac = UIAlertController(
            title: "Scanning not supported",
            message: "Your device does not support scanning a code from an item. Please use a device with a camera.",
            preferredStyle: .alert
        )
        
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection:
        AVCaptureConnection) {
        
        // self.logMessage = "Metadata found"
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            boundsView?.frame = CGRect.zero
            return
        }
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
                        
            // Prevent multiple lookups of same code/isbn
            if let _ = self.cache[stringValue] {
                Logger.log(msg: "Book already processed, ISBN: \(stringValue)")
                return
            }
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
//            let barCodeObject = previewLayer?.transformedMetadataObject(for: metadataObject)
//            boundsView?.frame = barCodeObject!.bounds
            
            // Stop capturing during processing
            captureSession.stopRunning()
            
            // Process the data - responsible for self.captureSession.startRunning() !
            process(code: stringValue)
        }
        
        dismiss(animated: true)
    }
    
    func process(code: String) {
        Logger.log(msg: "Processing book, ISBN: \(code)")
        
        DispatchQueue.global(qos: .utility).async {
            Logger.log(msg: "Fetching book info, ISBN: \(code)")
            
            let res = ResolverGoogleBooks.fetchBookInfo(isbn: code)

//            if let data = try? res.get() {
//                if (data == nil) {
//                    self.logMessage = "Fetching book info failed, ISBN: \(code)"
//                }
//            }
            
            if (try? res.get()) != nil {
                let _ = res.map { book in
                    if let book = book {
                        self.cache[code] = book
                        self.saveBookInfo(isbn: code, book: book)
                        // DispatchQueue.main.async { self.displayBookInfo(book: book) }
                    }
                }
            } else {
                Logger.log(msg: "Fetching book info failed, ISBN: \(code)")
            }

            // When metadata are proccessed, continue capturing again
            self.captureSession.startRunning()
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: Helpers
    
    private func saveBookInfo(isbn: String, book: BookItem) {
        Logger.log(msg: "Saving book info, ISBN: \(isbn)")
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
           let data = try encoder.encode(book)
            print(String(data: data, encoding: .utf8)!)
            Logger.log(msg: "Decoded book info, ISBN: \(isbn)")
        } catch {
            Logger.log(msg: "Unable to decode book info, ISBN: \(isbn)")
        }
        
        DispatchQueue.main.async {
            let item = Book(context: self.managedObjectContext)
            item.authors = book.volumeInfo.authors
            item.categories = book.volumeInfo.categories
            item.desc = book.volumeInfo.description
            item.isbn = isbn
            item.language = book.volumeInfo.language
            item.pageCount = Int64(truncatingIfNeeded: book.volumeInfo.pageCount ?? 0)
            item.publishedDate = book.volumeInfo.publishedDate
            item.subtitle = book.volumeInfo.subtitle
            item.title = book.volumeInfo.title
            
            do {
                try self.managedObjectContext.save()
                Logger.log(msg: "Saved book info, ISBN: \(isbn)")
                
            } catch let error {
                Logger.log(msg: "Unable to save book info: ISBN \(isbn), reason: \(error)")
            }
        }
    }

}

extension ScanViewController: UIViewControllerRepresentable {
    
    public typealias UIViewControllerType = ScanViewController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ScanViewController>) -> ScanViewController {
        return ScanViewController(managedObjectContext: self.managedObjectContext)
    }
    
    func updateUIViewController(_ uiViewController: ScanViewController, context: UIViewControllerRepresentableContext<ScanViewController>) {
    }
}



struct ScanViewController_Previews: PreviewProvider {
    static var previews: some View {
        Text("ScanViewController Preview")
    }
}
