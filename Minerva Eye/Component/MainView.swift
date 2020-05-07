//
//  MainView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/30/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
//    @FetchRequest(
//        entity: Book.entity(),
//        sortDescriptors: [
//            NSSortDescriptor(keyPath: \Book.title, ascending: true),
//        ]
//    ) var data: FetchedResults<Book>
    
    @State var selection: Int = 0
    
    var body: some View {
        TabView(selection: self.$selection){
            BooksView()
                .tabItem {
                    VStack {
                        Image(systemName: "book")
                        Text("Books")
                        // Text("Books (\(self.data.count))")
                    }
                    // .navigationBarTitle(Text("Library"), displayMode: .inline)
            }
            .tag(0)
            
            ScanView()
                .tabItem {
                    VStack {
                        Image(systemName: "camera")
                        Text("Scan")
                    }
                    // .navigationBarTitle(Text("Scan"), displayMode: .inline)
            }
            .tag(1)
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    @State var selection: Int = 0
//    
//    static var previews: some View {
//        MainView(selection: self.$selection)
//    }
//}
