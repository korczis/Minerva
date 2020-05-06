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
    
    @State var handleScan: () -> ()
 
    var body: some View {
        NavigationView {
             VStack {
                BooksListView(handleScan: self.handleScan)
            }
        }
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        BooksView(handleScan: {})
    }
}
