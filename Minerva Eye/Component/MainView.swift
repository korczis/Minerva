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
    
    @State var selection: MainView.Tab = .Library
    
    var body: some View {
        TabView(selection: self.$selection) {
            BooksView()
                .tabItem {
                    VStack {
                        Image(systemName: "book")
                        Text("Library (\(self.data.count))")
                    }
                    .navigationBarTitle(Text("Library (\(self.data.count))"), displayMode: .inline)
            }
            .tag(MainView.Tab.Library)
            
            ScanView()
                .tabItem {
                    VStack {
                        Image(systemName: "camera")
                        Text("Scan")
                    }
                    .navigationBarTitle(Text("Scan"), displayMode: .inline)
            }
            .tag(MainView.Tab.Scan)
        }
    }
}

extension MainView {
    enum Tab: Hashable {
        case Library
        case Scan
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
