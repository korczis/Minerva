//
//  MainView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/30/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @FetchRequest(
        entity: Book.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Book.title, ascending: true),
        ]
    ) var data: FetchedResults<Book>
    
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection){
            BooksView(handleScan: {
                DispatchQueue.main.async {
                    self.selection = 0
                }
            })
                .tabItem {
                    VStack {
                        Image(systemName: "book")
                        Text("Books (\(self.data.count))")
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
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
