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
                
                // Authors
                if data.authors != nil {
                    Text("Author")
                        .font(.headline)
                        .padding(.top, 10)
                    Text("\(data.authors?.joined(separator: ", ") ?? "N/A")")
                        .padding(.top, 3)
                }
                
                // Subtitle
                if data.subtitle != nil {
                    Text("Subtitle")
                        .font(.headline)
                        .padding(.top, 10)
                    Text("\(data.subtitle ?? "N/A")")
                        .padding(.top, 3)
                }
                
                // Categories
                if data.categories != nil {
                    Text("Categories")
                        .font(.headline)
                        .padding(.top, 10)
                    Text("\(data.categories?.joined(separator: ", ") ?? "N/A")")
                        .padding(.top, 3)
                }
                
                // Subtitle
                if data.language != nil {
                    Text("Language")
                        .font(.headline)
                        .padding(.top, 10)
                    Text("\(data.language ?? "N/A")")
                        .padding(.top, 3)
                }
                
                // ISBN
                if data.isbn != nil {
                    Text("ISBN")
                        .font(.headline)
                        .padding(.top, 10)
                    Text("\(data.isbn ?? "N/A")")
                        .padding(.top, 3)
                }
                
                // Pubished Date
                if data.publishedDate != nil {
                    Text("Published Date")
                        .font(.headline)
                        .padding(.top, 10)
                    Text("\(data.publishedDate ?? "N/A")")
                        .padding(.top, 3)
                }
                
                
                
//                // Pages
//                if data.pageCount != nil {
//                    Text("Pages")
//                        .font(.headline)
//                        .padding(.top, 10)
//                    Text("\(data.pageCount)")
//                        .padding(.top, 3)
//                }
                
                // Description
                if data.desc != nil {
                    Text("Description")
                        .font(.headline)
                        .padding(.top, 10)
                    Text("\(data.desc ?? "N/A")")
                        .padding(.top, 3)
                        .lineLimit(nil)
                }
                
//                Text("Before Image")
//
//                Image(uiImage: self.barcodeImage ?? generateBarcode(from: data.isbn!)!)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 250.0, height: 250.0)
                
                Spacer()
            }
            .navigationBarTitle("Book Details")
            .padding()
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
