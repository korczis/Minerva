//
//  AppState.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 5/9/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import Foundation

class AppState: ObservableObject {
//    private static var DefaultNotificationCenter = NotificationCenter.default
//    static let NotificationName = Notification.Name("LogMessage")
    
    @Published var selectedView: MainView.Tab = .Library
    
    func selectView(view: MainView.Tab) -> Void {
        Logger.log(msg: "Selecting View - \(view)")
        DispatchQueue.main.async {
            self.selectedView = view
        }
    }
}

