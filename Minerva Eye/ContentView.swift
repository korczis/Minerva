//
//  ContentView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection){
            ScanView()
                .tabItem {
                    VStack {
                        Image(systemName: "camera")
                        Text("Scan")
                    }
                }
                .tag(0)
            
            ManageView()
                .tabItem {
                    VStack {
                        Image(systemName: "book")
                        Text("Manage")
                    }
                }
                .tag(1)
            
            LogsView()
                .tabItem {
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("Logs")
                    }
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
