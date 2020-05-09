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
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            
            // MARK: Quick How-To
            Group {
                NavigationLink(destination: GettingStartedView()) {
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
                                Text("Scan book")
                                Text("Open Library")
                                Text("Tap the book")
                            }
                            .font(.body)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        
                    }
                    .padding(.top)
                }
                .disabled(true)
            }
            
            Divider()
            
            NavigationLink(destination: ScanView()) { // MainView(selection: MainView.Tab.Library
                InformationDetailView(
                    title: "Scan",
                    subTitle: "Add new books",
                    imageName: "camera"
                )
            }
            
            NavigationLink(destination: BooksView()) { // MainView(selection: MainView.Tab.Library)
                InformationDetailView(
                    title: "Library",
                    subTitle: "Manage your books",
                    imageName: "book"
                )
            }
            
            Divider()
            
            // MARK: Eye View
            NavigationLink(destination: EyeView()) {
                InformationDetailView(
                    title: "Eye",
                    subTitle: "Experimental Eye View",
                    imageName: "eye"
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
                    .cornerRadius(25)
                
            }
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
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
