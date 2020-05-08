//
//  ScanView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI
import AVFoundation

//extension UIView {
//    func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
//        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
//            self.alpha = 1.0
//        }, completion: completion)
//    }
//
//    func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 3.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
//        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
//            self.alpha = 0.0
//        }, completion: completion)
//    }
//}

//class ScanViewModel: ObservableObject {
//    @State var logMessageOpacity = 1.0
//
//    @Published var logMessage = "" {
//        didSet {}
//    }
//}

struct ScanView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var logMessage: String = ""
    @State private var logMessageOpacity = 1.0
    
    // @ObservedObject var model = ScanViewModel()
    
    let pub = NotificationCenter.default
        .publisher(for: NSNotification.Name("LogMessage"))
    
    var body: some View {
       return VStack {
            ZStack {
                ScanViewController(managedObjectContext: self.managedObjectContext)
                 // .navigationBarTitle(Text("Scan"), displayMode: .inline)
            }
            Text(self.logMessage)
                .padding(.bottom, 3)
                .transition(.slide)
                .opacity(self.logMessageOpacity)
                .onReceive(pub) { (output) in
                    print("RECEIVED NOTIFICATION - \(output)")
                    self.logMessage = output.object! as! String
                    self.logMessageOpacity = 1.0
                    
                    withAnimation(.easeOut(duration: 3)) { // .linear(duration: 3)
                        self.logMessageOpacity = 0.0
                    }
                }
        }
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
