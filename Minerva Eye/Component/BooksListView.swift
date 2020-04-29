//
//  ManageView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct BooksListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Book.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Book.title, ascending: true),
        ]
    ) var data: FetchedResults<Book>
    
    var handleScan: () -> ()
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(data, id: \.self) { book in
                        NavigationLink(destination: BookDetailView(data: book)) {
                            BooksListRowView(data: book)
                        }
                    }
                    .onDelete(perform: delete)
                }
                .navigationBarTitle(Text("Books"))
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach() { idx in
            // Saving the Delete operation
            let book = data[idx]
            do {
                managedObjectContext.delete(book)
                try managedObjectContext.save()
            } catch {
                Logger.log(msg: "Unable to delete book: \(book)")
            }
        }
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        BooksListView(handleScan: {})
    }
}
