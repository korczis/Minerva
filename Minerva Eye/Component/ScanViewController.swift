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
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var boundsView: UIView?
    
    // korczis
//    var lookupEnabled: Bool = true
//    var bookCache: [String: BookItem] = [:]

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
            metadataOutput.metadataObjectTypes = [.qr, .ean13, .code128]

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
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
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
        // captureSession.stopRunning()
        
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
        print(code)
        
//        if(!lookupEnabled) {
//            return
//        }
//
//        lookupEnabled = false
//
//        if let book = bookCache[code] {
//            print("Using cached book info - ISBN: \(code)")
//            displayBookInfo(book: book)
//        } else {
//            print("Fetching book info - ISBN: \(code)")
//            fetchBookInfo(isbn: code)
//        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: Helpers
    
//    private func displayBookInfo(book: BookItem) {
//        let encoder = JSONEncoder()
//        encoder.outputFormatting = .prettyPrinted
//        do {
//           let data = try encoder.encode(book)
//            print(String(data: data, encoding: .utf8)!)
//        } catch {
//            print(error)
//        }
//
//        // create the alert
//        let title = book.volumeInfo.title;
//        let message = book.volumeInfo.subtitle;
//
//        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//
//        // add an action (button)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) -> Void in
//            self.lookupEnabled = true
//        }))
//
//        // show the alert
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    private func fetchBookInfo(isbn: String) {
//        if let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)&key=") {
//            let task = URLSession.shared.dataTask(with: url) { data, response, error in
//                if let data = data {
//                    do {
//                        let res = try JSONDecoder().decode(BookQueryResult.self, from: data)
//                        if(!res.items.isEmpty) {
//                            let book = res.items[0]
//
//                            self.bookCache[isbn] = book
//
//                            DispatchQueue.main.async {
//                                // self.tabBarController?.selectedIndex = 1
//                                self.displayBookInfo(book: book)
//                            }
//                        }
//
//                    } catch let error {
//                        self.lookupEnabled = true
//                        print(error)
//                    }
//                }
//            }
//
//            task.resume()
//        }
//    }
}

extension ScanViewController: UIViewControllerRepresentable {

    public typealias UIViewControllerType = ScanViewController

    func makeUIViewController(context: UIViewControllerRepresentableContext<ScanViewController>) -> ScanViewController {
        
        return ScanViewController()
    }
    
    func updateUIViewController(_ uiViewController: ScanViewController, context: UIViewControllerRepresentableContext<ScanViewController>) {
        
    }
}


