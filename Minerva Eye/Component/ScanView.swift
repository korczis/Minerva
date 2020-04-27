//
//  ScanView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI
import AVFoundation

struct ScanView: View {
    var body: some View {
        ScanViewController()
        
//        NavigationView {
//            ZStack {
//                ScanViewController()
//                Text("Scan Window")
//                    .font(.title)
//                    .navigationBarTitle(Text("Scanner"), displayMode: .inline)
//            }
//        }
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
