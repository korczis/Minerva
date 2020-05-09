//
//  AppState.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 5/9/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import Foundation
import SwiftUI

class AppState: ObservableObject {
    @Published var selectedView: AppState.View = .Library
    @Published var showActionSheet: Bool = false
}

extension AppState {
    enum View: Hashable {
        case Library
        case Scan
    }
}
