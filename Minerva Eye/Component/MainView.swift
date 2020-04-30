//
//  MainView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/30/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        BooksView()
            .navigationBarTitle("Books")
        
//        NavigationView {
//            NavigationLink(destination: BooksView()) {
//                HStack {
//                    Image(systemName: "book")
//                        .font(.title)
//                    Text("Books")
//                        .fontWeight(.semibold)
//                        .font(.title)
//                }
//                .padding()
//                .foregroundColor(.white)
//                .background(Color.blue)
//                .cornerRadius(40)
//            }
//        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
