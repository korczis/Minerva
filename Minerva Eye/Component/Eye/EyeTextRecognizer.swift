//
//  EyeTextRecognizer.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 5/14/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import Foundation
import Vision
import VisionKit

final class EyeTextRecognizer {
    static let RecognitionLanguages: [String] = [
        "cs-CZ",
        "en-GB",
        "en-US",
    ]
    let cameraScan: VNDocumentCameraScan
    
    init(cameraScan: VNDocumentCameraScan) {
        self.cameraScan = cameraScan
    }
    
//    private let queue = DispatchQueue(label: "com.augmentedcode.scan", qos: .default, attributes: [], autoreleaseFrequency: .workItem)
    
    private let queue = DispatchQueue.main
    
    func recognizeText(withCompletionHandler completionHandler: @escaping ([String]) -> Void) {
        queue.async {
            let images = (0..<self.cameraScan.pageCount).compactMap({ self.cameraScan.imageOfPage(at: $0).cgImage })
            
            let request = VNRecognizeTextRequest()
            request.recognitionLanguages = EyeTextRecognizer.RecognitionLanguages
            
            request.recognitionLevel = .accurate
            request.usesLanguageCorrection = true
            
            let imagesAndRequests = images.map({ (image: $0, request: request) })
            
            let textPerPage = imagesAndRequests.map { image, request -> String in
                let handler = VNImageRequestHandler(cgImage: image, options: [:])
                do {
                    try handler.perform([request])
                    guard let observations = request.results as? [VNRecognizedTextObservation] else { return "" }
                    return observations.compactMap({ $0.topCandidates(1).first?.string }).joined(separator: "\n")
                }
                catch {
                    Logger.log(msg: "\(error)")
                    return ""
                }
            }
            DispatchQueue.main.async {
                completionHandler(textPerPage)
            }
        }
    }
}
