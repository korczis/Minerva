//
//  ScanViewController.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import AVFoundation
import UIKit
import SwiftUI

final class ScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @Binding var data: [BookItem]
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var boundsView: UIView?
    
    init(data: Binding<[BookItem]> = .constant([])) {
        self._data = data
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
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            boundsView?.frame = CGRect.zero
            return
        }
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            let barCodeObject = previewLayer?.transformedMetadataObject(for: metadataObject)
            boundsView?.frame = barCodeObject!.bounds
            
            // Process result
            found(code: stringValue)
        }
        
        dismiss(animated: true)
    }
    
    func found(code: String) {
        print("Recognized code \(code)")
        
        DispatchQueue.global(qos: .utility)
            .async {
                let _ = Resolver.fetchBookInfo(isbn: code)
                    .map { book in
                        if let book = book {
                            self.displayBookInfo(book: book)
                            // DispatchQueue.main.async { self.displayBookInfo(book: book) }
                        }
                    }
            }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: Helpers
    
    private func displayBookInfo(book: BookItem) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
           let data = try encoder.encode(book)
            print(String(data: data, encoding: .utf8)!)
        } catch {
            print(error)
        }
        
        DispatchQueue.main.async {
            self.data.append(book)
        }
//
//        // create the alert
//        let title = book.volumeInfo.title;
//        let message = book.volumeInfo.subtitle;
//
//        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//
//        // add an action (button)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) -> Void in
//            // self.lookupEnabled = true
//        }))
//
//        // show the alert
//        self.present(alert, animated: true, completion: nil)
    }

}

extension ScanViewController: UIViewControllerRepresentable {
    
    public typealias UIViewControllerType = ScanViewController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ScanViewController>) -> ScanViewController {
        return ScanViewController(data: $data)
    }
    
    func updateUIViewController(_ uiViewController: ScanViewController, context: UIViewControllerRepresentableContext<ScanViewController>) {
    }
}



struct ScanViewController_Previews: PreviewProvider {
    static var previews: some View {
        Text("ScanViewController Preview")
    }
}
