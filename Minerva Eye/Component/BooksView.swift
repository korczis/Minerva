//
//  MainView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/30/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct BooksView: View {
    @State private var selection = 0
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Book.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Book.title, ascending: true),
        ]
    ) var data: FetchedResults<Book>
 
    var body: some View {
        TabView(selection: $selection){
            BooksListView(handleScan: {
                DispatchQueue.main.async {
                    self.selection = 0
                }
            })
                .tabItem {
                    VStack {
                        Image(systemName: "book")
                        // Text("Books")
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

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        BooksView()
    }
}
