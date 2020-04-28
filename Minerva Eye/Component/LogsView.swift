//
//  LogsView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct LogsView: View {
    var data: [String] = []
    
    var body: some View {
        VStack {
            Text("Logs")
                .font(.title)
            
            List(data, id: \.self) { log in
                Text(log)
            }
        }
    }
}

struct LogsView_Previews: PreviewProvider {
    static var previews: some View {
        LogsView()
    }
}
