//
//  MainView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/30/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Book.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Book.title, ascending: true),
        ]
    ) var data: FetchedResults<Book>
    
    // @State var selection: MainView.Tab = .Library
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        TabView(selection: $appState.selectedView) {
            BooksView()
                .tabItem {
                    VStack {
                        Image(systemName: "book")
                        Text("Library (\(self.data.count))")
                    }
                    .navigationBarTitle(Text("Library (\(self.data.count))"), displayMode: .inline)
            }
            .tag(MainView.Tab.Library)
            .environmentObject(appState)
            
            EyeView()
                .tabItem {
                    VStack {
                        Image(systemName: "eye")
                        Text("Eye")
                    }
                    .navigationBarTitle(Text("Eye"), displayMode: .inline)
            }
            .tag(MainView.Tab.Eye)
            
            ScanView()
                .tabItem {
                    VStack {
                        Image(systemName: "camera")
                        Text("Scan")
                    }
                    .navigationBarTitle(Text("Scan"), displayMode: .inline)
            }
            .tag(MainView.Tab.Scan)
        }
    }
}

extension MainView {
    class ViewModel: ObservableObject {
        var selectedTab: MainView.Tab = .Library {
            willSet { objectWillChange.send() }
        }
        // Alternatively:
        // @Published var selectedTab: ContentView.Tab = .home
    }
}

extension MainView {
    enum Tab: Hashable {
        case Eye
        case Library
        case Scan
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
