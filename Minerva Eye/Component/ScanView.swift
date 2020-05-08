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

struct ScanView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var logMessage: String = ""
    
    var body: some View {
        VStack {
            ZStack {
                ScanViewController(logMessage: $logMessage, managedObjectContext: self.managedObjectContext)
                 // .navigationBarTitle(Text("Scan"), displayMode: .inline)
            }
            Text(logMessage)
                .padding(.bottom, 3)
        }
        // .navigationBarTitle(Text("Scan"), displayMode: .inline)
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
