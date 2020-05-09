//
//  SplashScreenView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 5/7/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var clicks: Int = 0
    @State private var messages: [String] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center) {
                    Spacer()
                    
                    TitleView(clicks: $clicks)
                    
                    InformationContainerView(clicks: $clicks, messages: $messages)
                    
                    Spacer(minLength: 30)
                }
            }
            .navigationBarTitle(Text("Home"), displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onReceive(Logger.publisher()) { (output) in
            DispatchQueue.main.async {
                puts("Received new log message!")
                let msg = output.object! as! String
                self.messages.append(msg)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
