//
//  TitleView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 5/9/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    @Binding var clicks: Int
    
    static let HiddenClicks = 13;
    
    var body: some View {
        // NavigationLink(destination: BooksView()) {
         
        return VStack {
            Text("Minerva Eye")
                .font(.largeTitle)
                .foregroundColor(.blue)
            
            Button(action: {
                self.clicks = (self.clicks + 1) % (TitleView.HiddenClicks + 1)
                
                puts("Minerva Logo clicked - \(self.clicks)")
            }) {
                Image(uiImage: UIImage(named: "AppIcon")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, alignment: .center)
                    // .accessibility(hidden: true)
                    .cornerRadius(25)
            }
            .padding(.bottom)
        }
        // }
    }
}
