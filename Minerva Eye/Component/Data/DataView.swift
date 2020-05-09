//
//  DataView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 5/9/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

func createFile() {
    let fileName = "Testovacka"
    let documentDirURL = try! FileManager.default.url(
        for: .documentDirectory,
        in: .allDomainsMask,
        appropriateFor: nil,
        create: true
    )
    
    let fileURL = documentDirURL
        .appendingPathComponent(fileName)
        .appendingPathExtension("txt")
    
    print("File Path: \(fileURL.path)")
    
    let str = "Hello World"
    do {
        try str.write(to: fileURL, atomically: true, encoding: .utf8)
        print("Wrote data - \(str)")
        
        let input = try String(contentsOf: fileURL)
        print("Read data - \(input)")
        
    } catch {
        print(error.localizedDescription)
    }
}

struct DataView: View {
    @FetchRequest(
        entity: Book.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Book.title, ascending: true),
        ]
    ) var data: FetchedResults<Book>
    
    var body: some View {
        Button(action: {
            for item in self.data {
                print("Item - \(item)")
            }
            
            createFile()
        }) {
            Text("Export Data")
        }
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
