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
        
    var body: some View {
        List {
            ForEach(data, id: \.self) { book in
                NavigationLink(destination: BookDetailView(data: book)) {
                    BooksListRowView(data: book)
                }
            }
            .onDelete(perform: delete)
        }
        .id(UUID())
    }
    
    func delete(at offsets: IndexSet) {
        DispatchQueue.main.async {
            offsets.forEach() { idx in
                // Saving the Delete operation
                do {
                    self.managedObjectContext.delete(self.data[idx])
                    try self.managedObjectContext.save()
                } catch {
                    print("Failed saving")
                }
            }
        }
    }
}

struct BooksListView_Previews: PreviewProvider {
    static var previews: some View {
        BooksListView()
    }
}
