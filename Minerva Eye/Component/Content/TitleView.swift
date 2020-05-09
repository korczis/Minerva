//
//  TitleView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 5/9/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    var body: some View {
        NavigationLink(destination: BooksView()) {
            VStack {
                Text("Minerva Eye")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                
                Image(uiImage: UIImage(named: "AppIcon")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, alignment: .center)
                    // .accessibility(hidden: true)
                    .cornerRadius(25)
            
            }
        }
    }
}
