//
//  ScanView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI
import AVFoundation

struct ScanView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var logMessage: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ScanViewController(logMessage: $logMessage, managedObjectContext: self.managedObjectContext)
                        .navigationBarTitle(Text("Scan"), displayMode: .inline)
                }
                Text(logMessage)
                    .padding(.bottom, 3)
            }
        }
        .navigationBarTitle(Text("Scan"), displayMode: .inline)
        .navigationViewStyle(StackNavigationViewStyle())
//        .navigationBarItems(leading:
//            HStack {
//                Button("Books") {
//                    print("Books - tapped!")
//                }
//                .disabled(true)
//            }
//        )
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
