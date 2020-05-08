//
//  ScanView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI
import AVFoundation

extension UIView {
    func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }

    func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 3.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}

//class ScanViewModel: ObservableObject {
//    @Published var logMessage = "" {
//        didSet {
//            print("set")
//            //do whatever you want
//        }
//    }
//}

//func createLogLine(text: String): Text {
//    return Text(text)
//        .padding(.bottom, 3)
//        .transition(.slide)
//        .onReceive(pub) { (output) in
//            print("RECEIVED NOTIFICATION - \(output)")
//            let msg = output.object! as! String
//            self.logMessage = msg
//        }
//}

struct ScanView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var logMessage: String = ""
    
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
                .onReceive(pub) { (output) in
                    print("RECEIVED NOTIFICATION - \(output)")
                    let msg = output.object! as! String
                    self.logMessage = msg
                }
        }
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
