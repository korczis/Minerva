//
//  ManageView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct BooksView: View {
    var data: [BookItem] = []
    
    var body: some View {
        VStack {
            Text("Books View")
                .font(.title)
            
            List(data, id: \.self) { log in
                Text(log.volumeInfo.title)
            }
        }
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        BooksView()
    }
}
