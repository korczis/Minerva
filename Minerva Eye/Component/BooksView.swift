//
//  ManageView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct BookDetailView: View {
    @State var data: Book
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                Text(data.title ?? "N/A")
                    .font(.title)
                
                Text("Author")
                    .font(.headline)
                    .padding(.top, 10)
                Text("\(data.authors?.joined(separator: ", ") ?? "N/A")")
                    .padding(.top, 3)
                    
                Text("Subtitle")
                    .font(.headline)
                    .padding(.top, 10)
                Text("\(data.subtitle ?? "N/A")")
                    .padding(.top, 3)
                
                Text("Description")
                    .font(.headline)
                    .padding(.top, 10)
                Text("\(data.desc ?? "N/A")")
                    .padding(.top, 3)
                    .lineLimit(nil)
                
//                Text("Before Image")
//
//                Image(uiImage: self.barcodeImage ?? generateBarcode(from: data.isbn!)!)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 250.0, height: 250.0)
                
                Spacer()
            }
        }
    }
    
//    func generateBarcode(from string: String) -> UIImage? {
//        let data = string.data(using: String.Encoding.ascii)
//
//        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
//            filter.setValue(data, forKey: "inputMessage")
//            let transform = CGAffineTransform(scaleX: 3, y: 3)
//
//            if let output = filter.outputImage?.transformed(by: transform) {
//                print("generateBarcode() - generated barcode image")
//                let res = UIImage(ciImage: output)
//                DispatchQueue.main.async {
//                    self.barcodeImage = res
//                }
//                return res
//            }
//        }
//
//        print("generateBarcode() - failed to generate barcode image")
//        return nil
//    }
}

struct BooksViewRow: View {
    @State var data: Book
    @State var idx: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
//                Text("\(idx)")
//                    .font(.title)
                
                Text(data.title ?? "N/A")
                    .font(.title)
            }
            
            Text(data.authors?.joined(separator: ", ") ?? "N/A")
        }
    }
}

struct BooksView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Book.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Book.title, ascending: true),
        ]
    ) var data: FetchedResults<Book>
    
    var handleScan: () -> ()
    
    var body: some View {
        VStack {
            NavigationView {
                List(data.indices, id: \.self) { idx in
                    NavigationLink(destination: BookDetailView(data: self.data[idx])) {
                        BooksViewRow(data: self.data[idx], idx: idx)
                    }
                }
                .navigationBarTitle(Text("Books"))
            }
        }
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        BooksView(handleScan: {})
    }
}
