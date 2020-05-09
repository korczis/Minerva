//
//  LogView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 5/9/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct LogView: View {
    @Binding var messages: [String]
    
    var body: some View {
        VStack {
            List(self.messages, id: \.self) { msg in
                Text("\(msg)")
            }
            .id(UUID())
        }
        
    }
}

//struct LogView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogView()
//    }
//}
