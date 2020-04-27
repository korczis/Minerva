//
//  LogsView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

//struct LogDetail: View {
//    var log: String = ""
//
//    var body: some View {
//        Text("Log Detail")
//    }
//}

struct LogsView: View {
    var data: [String] = []
    
    var body: some View {
        VStack {
            Text("Logs View")
                .font(.title)
            
            List(data, id: \.self) { log in
                Text(log)
            }
        }
//        NavigationView {
//            ForEach(logsData.entries, id: \.self) { log in
//                NavigationLink(destination: LogDetail(log: log)) {
//                    Text(log)
//                }
//                Text(log)
//            }
//            .navigationBarTitle(Text("Landmarks"))
//        }
    }
}

struct LogsView_Previews: PreviewProvider {
    static var previews: some View {
        LogsView()
    }
}
