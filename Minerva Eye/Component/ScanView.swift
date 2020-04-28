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
    @Binding var data: [BookItem]
    
    init(data: Binding<[BookItem]> = .constant([])) {
        self._data = data
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScanViewController(data: $data)
                    .navigationBarTitle(Text("Scan"))
            }
        }
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
