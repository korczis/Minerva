//
//  ManageView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct BookDetailView: View {
    var data: BookItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(data.volumeInfo.title)
                .font(.title)
            
            Text("Author: \(data.volumeInfo.authors[0])")
            
            Text("Subtitle: \(data.volumeInfo.subtitle!)")
            
            Spacer()
        }
    }
}


struct BookListView: View {
    var data: [BookItem] = []
    
    var body: some View {
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

struct BooksViewRow: View {
    var data: BookItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(data.volumeInfo.title)
                .font(.title)
            
            Text(data.volumeInfo.authors[0])
        }
    }
}

struct BooksView: View {
    var data: [BookItem] = []
    
    var body: some View {
        VStack {
//            Text("Books")
//                .font(.title)
            
            BookListView(data: data)
        }
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        BooksView()
    }
}
