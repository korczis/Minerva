//
//  EyeView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 5/9/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct EyeViewOld: View {
    var body: some View {
        VStack {
           ZStack {
               EyeViewController()
           }
        }
    }
}

struct EyeViewOld_Previews: PreviewProvider {
    static var previews: some View {
        EyeViewOld()
    }
}
