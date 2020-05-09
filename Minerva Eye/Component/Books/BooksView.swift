//
//  MainView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/30/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct BooksView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // @EnvironmentObject var appState: AppState
    @EnvironmentObject var appState: AppState
    
    @FetchRequest(
        entity: Book.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Book.title, ascending: true),
        ]
    ) var data: FetchedResults<Book>
    
    var body: some View {
        VStack {
            BooksListView()
        }
        .navigationBarTitle("Library (\(self.data.count))")
        .navigationBarItems(trailing:
            Button(action: {
                Logger.log(msg: "Scan button clicked!")
                self.appState.selectView(view: MainView.Tab.Scan)
            })
            {
                Text("Scan")
                    .foregroundColor(.blue)
            }
        )
    }
}

//struct BooksView_Previews: PreviewProvider {
//    static var previews: some View {
//        BooksView()
//    }
//}
