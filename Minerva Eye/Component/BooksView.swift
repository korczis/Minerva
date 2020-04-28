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
            
            Text("Author")
                .font(.headline)
                .padding(.top, 10)
            Text("\(data.volumeInfo.authors[0])")
                .padding(.top, 3)
                
            Text("Subtitle")
                .font(.headline)
                .padding(.top, 10)
            Text("\(data.volumeInfo.subtitle ?? "N/A")")
                .padding(.top, 3)
            
            Text("Description")
                .font(.headline)
                .padding(.top, 10)
            Text("\(data.volumeInfo.description ?? "N/A")")
                .padding(.top, 3)
            
            Spacer()
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
    var handleScan: () -> ()
    
    var body: some View {
        VStack {
            NavigationView {
                List(data, id: \.self) { book in
                    NavigationLink(destination: BookDetailView(data: book)) {
                        BooksViewRow(data: book)
                    }
                }
//                .navigationBarItems(
//                    trailing: HStack {
//                        Button(action: {
//                            self.handleScan()
//                        }) {
//                            Image(systemName: "camera")
//                                .font(.largeTitle)
//                        }.foregroundColor(.blue)
//                    }
//                )
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
