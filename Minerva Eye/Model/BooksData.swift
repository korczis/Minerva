//
//  BooksData.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI
import Combine

final class BooksData: ObservableObject  {
    @Published var cache: [String: BookItem] = [:]
}
