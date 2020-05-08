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
            NavigationLink(destination: MainView(selection: MainView.Tab.Library)) { // MainView.Tab.Scan
                InformationDetailView(
                    title: "Scan",
                    subTitle: "Manage your books using ISBN/Barcodes",
                    imageName: "camera"
                )
            }
            
            NavigationLink(destination: MainView(selection: MainView.Tab.Library)) {
                InformationDetailView(
                    title: "Library",
                    subTitle: "Keep your books organized",
                    imageName: "book"
                )
            }
            
            Group {
                HStack(alignment: .center) {
                    Image(systemName: "questionmark.circle")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                        .padding()
                        .accessibility(hidden: true)
                    
                    VStack(alignment: .leading) {
                        Text("Getting Started")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .accessibility(addTraits: .isHeader)
                        
                        Group {
                            Text("Go to Scan View")
                            Text("Scan ISBN/Barcode of your book")
                            Text("Go to Library View")
                            Text("Click on book see details")
                        }
                        .font(.body)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                        
                }
                .padding(.top)
            }
            
            // Testing stuff
            Group {
                Button(action: {
                    ResolverGoodReads.fetchBookInfo(isbn: "9780140514810")
                }) {
                    Text("Test GoodReads")
                }
            }
            
        }
        .padding(.horizontal)
    }
}

struct TitleView: View {
    var body: some View {
        NavigationLink(destination: MainView(selection: MainView.Tab.Library)) {
            VStack {
                Text("Minerva Eye")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                
                Image(uiImage: UIImage(named: "AppIcon")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, alignment: .center)
                    .accessibility(hidden: true)
                    .cornerRadius(25)
            
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center) {
                    Spacer()
                    
                    TitleView()
                    
                    InformationContainerView()
                    
                    Spacer(minLength: 30)
                }
            }
            .navigationBarTitle(Text("Home"), displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
