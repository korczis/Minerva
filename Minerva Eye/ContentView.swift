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
    @EnvironmentObject var stateData: StateData
 
    var body: some View {
        TabView(selection: $selection){
            ScanView(data: $stateData.books)
                .tabItem {
                    VStack {
                        Image(systemName: "camera")
                        Text("Scan")
                    }
                }
                .tag(0)
            
            BooksView(data: stateData.books)
                .tabItem {
                    VStack {
                        Image(systemName: "book")
                        Text("Books")
                    }
                }
                .tag(1)
            
            LogsView(data: stateData.logs)
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
            .environmentObject(StateData())
    }
}
