//
//  ManageView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct BooksListRowView: View {
    @State var data: Book
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(data.title ?? "N/A")
                    .font(.title)
            }
            
            Text(data.authors?.joined(separator: ", ") ?? "N/A")
        }
    }
}

#if DEBUG
struct BooksListRowView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
      @State() var data: Book = Book ()

      var body: some View {
        BooksListRowView(data: data)
      }
    }
}
#endif
