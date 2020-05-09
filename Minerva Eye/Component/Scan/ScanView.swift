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
    
//    @FetchRequest(
//        entity: Book.entity(),
//        sortDescriptors: [
//            NSSortDescriptor(keyPath: \Book.title, ascending: true),
//        ]
//    ) var data: FetchedResults<Book>
    
    @State private var logMessage: String = ""
    @State private var logMessageOpacity = 1.0
    
    // @ObservedObject var model = ScanViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                ScanViewController(managedObjectContext: self.managedObjectContext)
            }
            
            Text(self.logMessage)
                .padding(.bottom, 3)
                .transition(.slide)
                .opacity(self.logMessageOpacity)
                .onReceive(Logger.publisher()) { (output) in
                    DispatchQueue.main.async {
                        self.logMessage = output.object! as! String
                        self.logMessageOpacity = 1.0
                        
                        withAnimation(.easeOut(duration: 5)) {
                            self.logMessageOpacity = 0.0
                        }
                    }
            }
        }.navigationBarTitle("Scan")
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
