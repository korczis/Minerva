//
//  EyeView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 5/14/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct EyeView: View {
    // @State private var completionHandler: ([String]?) -> Void
    
    @State private var isShowingScannerSheet = false
    @State private var text: String = ""
    
    private let buttonInsets = EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
    private let completionHandler: ([String]?) -> Void
    
    @Environment(\.presentationMode) var presentation
    
    init(completion: @escaping ([String]?) -> Void) {
        self.completionHandler = completion
    }
    
    var body: some View {
        VStack {
            EyeScannerView(completion: { textPerPage in
                if let text = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines) {
                    self.text = text
                    print("Recognized text: \(text)")
                    self.completionHandler([text])
                }
                
                self.isShowingScannerSheet = false
                self.presentation.wrappedValue.dismiss()
            })
            .edgesIgnoringSafeArea(.all)
        }
        .sheet(isPresented: self.$isShowingScannerSheet) {
            self.makeScannerView()
            
        }
    }
    
    private func openCamera() {
        isShowingScannerSheet = true
    }

    private func makeScannerView() -> EyeScannerView {
        EyeScannerView(completion: { textPerPage in
            if let text = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines) {
                self.text = text
                print("EyeScannerView completion, text - \(text)")
            }
            self.isShowingScannerSheet = false
            self.presentation.wrappedValue.dismiss()
        })
    }
}

#if DEBUG
struct EyeView_Previews: PreviewProvider {
    
    static var previews: some View {
        EyeView(completion: { msg in
            print(msg!)
        })
    }
}
#endif
