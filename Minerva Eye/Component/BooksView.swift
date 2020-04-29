//
//  ManageView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct BookDetailView: View {
    var data: Book
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                Text(data.title ?? "N/A")
                    .font(.title)
                
                Text("Author")
                    .font(.headline)
                    .padding(.top, 10)
                Text("\(data.authors?.joined(separator: ", ") ?? "N/A")")
                    .padding(.top, 3)
                    
                Text("Subtitle")
                    .font(.headline)
                    .padding(.top, 10)
                Text("\(data.subtitle ?? "N/A")")
                    .padding(.top, 3)
                
                Text("Description")
                    .font(.headline)
                    .padding(.top, 10)
                Text("\(data.desc ?? "N/A")")
                    .padding(.top, 3)
                    .lineLimit(nil)
                
                Spacer()
            }
        }
    }
}

struct BooksViewRow: View {
    var data: Book
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(data.title ?? "N/A")
                .font(.title)
            
            Text(data.authors?.joined(separator: ", ") ?? "N/A")
        }
    }
}

struct BooksView: View {
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
                List(data, id: \.self) { book in
                    NavigationLink(destination: BookDetailView(data: book)) {
                        BooksViewRow(data: book)
                    }
                }
                .navigationBarTitle(Text("Books"))
            }
        }
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        BooksView(handleScan: {})
    }
}
