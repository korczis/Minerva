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
            NavigationLink(destination: MainView(selection: 0)) {
                InformationDetailView(
                    title: "Library",
                    subTitle: "Keep your books organized",
                    imageName: "book"
                )
            }
            
            NavigationLink(destination: MainView(selection: 1)) {
                InformationDetailView(
                    title: "Scan",
                    subTitle: "Manage your books using ISBN/Barcodes",
                    imageName: "camera"
                )
            }
            
        }
        .padding(.horizontal)
    }
}

struct TitleView: View {
    var body: some View {
        NavigationLink(destination: MainView()) {
            VStack {
                Text("Minerva Eye")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                
                Image(uiImage: UIImage(named: "AppIcon")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, alignment: .center)
                    .accessibility(hidden: true)
            
            }
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
                
                //                Button(action: {
                //                    // let generator = UINotificationFeedbackGenerator()
                //                    // generator.notificationOccurred(.success)
                //                    print("Button clicked")
                //                }) {
                //                    NavigationLink(destination: MainView()) {
                //                        Text("Lets start")
                //                    }
                //                    // .customButton()
                //                }
                //                .padding(.horizontal)

                Group {
                    Text("How-To")
                        .font(.title)
                        .padding()

                   Text("1 - Go to scan view")
                   Text("2 - Scan barcode of your book")
                   Text("3 - Go books/library view")
                   Text("4 - Click on your scanned book to see detail")
                }
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
