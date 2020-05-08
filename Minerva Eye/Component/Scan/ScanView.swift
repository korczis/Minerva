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
    
    @FetchRequest(
        entity: Book.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Book.title, ascending: true),
        ]
    ) var data: FetchedResults<Book>
    
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
        }
        .navigationBarTitle("Scan (\(self.data.count))")
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
