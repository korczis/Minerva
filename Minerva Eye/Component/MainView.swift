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
    
    @FetchRequest(
        entity: Book.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Book.title, ascending: true),
        ]
    ) var data: FetchedResults<Book>
    
    @State var selection: AppState.View = .Library
    
    var body: some View {
        Group {
            if selection == .Scan {
                ScanView()
                    .navigationBarTitle(Text("Scan (\(self.data.count))"), displayMode: .inline)
                    .navigationBarItems(trailing:
                    Button(action: {
                            self.selection = .Library
                        })
                        {
                            Text("Library")
                                .foregroundColor(.blue)
                        }
                    )
            } else if selection == .Library {
                BooksView()
                    .navigationBarTitle(Text("Library (\(self.data.count))"), displayMode: .inline)
                    .navigationBarItems(trailing:
                    Button(action: {
                            self.selection = .Scan
                        })
                        {
                            Text("Scan")
                                .foregroundColor(.blue)
                        }
                    )
            }
        }
    }
    
//    var body: some View {
//        TabView(selection: self.$selection) {
//            BooksView()
//                .tabItem {
//                    VStack {
//                        Image(systemName: "book")
//                        Text("Library (\(self.data.count))")
//                    }
//                    .navigationBarTitle(Text("Library (\(self.data.count))"), displayMode: .inline)
//            }
//            .tag(AppState.View.Library)
//
//            ScanView()
//                .tabItem {
//                    VStack {
//                        Image(systemName: "camera")
//                        Text("Scan")
//                    }
//                    .navigationBarTitle(Text("Scan"), displayMode: .inline)
//            }
//            .tag(AppState.View.Scan)
//        }
//    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
