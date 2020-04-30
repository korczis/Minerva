//
//  ManageView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import CoreImage
import SwiftUI

struct BookDetailView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var data: Book
    var ciContext: CIContext = CIContext()
    
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
                
                VStack {
                    Image(uiImage: UIImage(barcode: data.isbn!)!)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .border(Color.black, width: 2)
                }
                .background(Color.white)
                
                Spacer()
            }
            .navigationBarTitle("Book Details")
            .navigationBarItems(trailing:
                Button(action: {
                    print("Deleting book \(self.data)")
                    
                    do {
                        self.managedObjectContext.delete(self.data)
                        try self.managedObjectContext.save()
                    } catch {
                        print("Failed to delete book \(self.data)")
                    }
                    
                     self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Delete")
                        .foregroundColor(.red)
                }
            )
            .padding()
        }
    }
}

extension UIImage {

    convenience init?(barcode: String) {
        let data = barcode.data(using: String.Encoding.ascii)
        
        let ciContext = CIContext()
        
        guard let filter = CIFilter(name: "CICode128BarcodeGenerator") else {
            return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        
        guard let output = filter.outputImage?.transformed(by: transform) else {
            return nil
        }

        guard let cgImage = ciContext.createCGImage(output, from: output.extent) else {
            return nil
        }
        
        self.init(cgImage: cgImage)
    }
    
    
    convenience init?(qrcode: String) {
        let data = qrcode.data(using: String.Encoding.ascii)
        
        let ciContext = CIContext()
        
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else {
            return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        
        guard let output = filter.outputImage?.transformed(by: transform) else {
            return nil
        }

        guard let cgImage = ciContext.createCGImage(output, from: output.extent) else {
            return nil
        }
        
        self.init(cgImage: cgImage)
    }
}
