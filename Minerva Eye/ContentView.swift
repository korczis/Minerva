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
//        BooksView(data: stateData.books)

        TabView(selection: $selection){
            BooksView(handleScan: {
                DispatchQueue.main.async {
                    self.selection = 0
                }
            })
                .tabItem {
                    VStack {
                        Image(systemName: "book")
                        Text("Books")
                    }
                }
                .tag(0)
            
            ScanView()
                .tabItem {
                    VStack {
                        Image(systemName: "camera")
                        Text("Scan")
                    }
                }
                .tag(1)

//            LogsView(data: stateData.logs)
//                .tabItem {
//                    VStack {
//                        Image(systemName: "list.bullet")
//                        Text("Logs")
//                    }
//                }
//                .tag(2)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(StateData())
//    }
//}
