//
//  SplashScreenView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 5/7/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct InformationDetailView: View {
    var title: String = "title"
    var subTitle: String = "subTitle"
    var imageName: String = "car"
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: imageName)
                .font(.largeTitle)
                .foregroundColor(.blue)
                .padding()
                .accessibility(hidden: true)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .accessibility(addTraits: .isHeader)
                
                Text(subTitle)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.top)
    }
}

struct InformationContainerView: View {
    var body: some View {
        VStack(alignment: .leading) {
            InformationDetailView(
                title: "Library",
                subTitle: "Keep your books organized in library",
                imageName: "book"
            )
            
            InformationDetailView(
                title: "Scan",
                subTitle: "Add and manage your libary with your camera",
                imageName: "camera"
            )
        }
        .padding(.horizontal)
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            Text("Minerva Eye")
                .font(.largeTitle)
                // .customTitleText()
                .foregroundColor(.blue)
            
            Image(uiImage: UIImage(named: "AppIcon")!)
                .resizable()
//                .scaledToFit()
                 .aspectRatio(contentMode: .fit)
                 .frame(width: 180, alignment: .center)
                .accessibility(hidden: true)
            
            // Text("Welcome to")
                // .customTitleText()
            
//            Text("Minerva Eye")
//                // .customTitleText()
//                .foregroundColor(.blue)
        }
    }
}

struct SplashScreenView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                
                Spacer()
                
                TitleView()
                
                InformationContainerView()
                
                Spacer(minLength: 30)
                
                Button(action: {
                    // let generator = UINotificationFeedbackGenerator()
                    // generator.notificationOccurred(.success)
                    print("Button clicked")
                }) {
                    NavigationLink(destination: MainView()) {
                        Text("Lets start")
                    }
                    // .customButton()
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitle(Text("Home"), displayMode: .inline)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
