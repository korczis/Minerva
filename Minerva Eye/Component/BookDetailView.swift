//
//  ManageView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import Combine
import CoreImage
import Foundation
import SwiftUI

///

struct CodeRenderer {
    static let ciContext: CIContext = CIContext()
}

struct BookDetailView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.imageCache) var cache: ImageCache
    
    @State var data: Book
    @State private var showingAlert = false
    
    private let pasteboard = UIPasteboard.general
  
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                Text(data.title ?? "N/A")
                    .font(.title)
                    .onTapGesture(count: 2) {
                        self.pasteboard.string = self.data.title!
                   }
                
                // Details
                Group {
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
                            .onTapGesture(count: 2) {
                                 self.pasteboard.string = self.data.subtitle!
                            }
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
                    
                    // Language
                    if data.language != nil {
                        Text("Language")
                            .font(.headline)
                            .padding(.top, 10)
                        Text("\(data.language ?? "N/A")")
                            .onTapGesture(count: 2) {
                                 self.pasteboard.string = self.data.language!
                            }
                            .padding(.top, 3)
                    }
                    
                    // ISBN
                    if data.isbn != nil {
                        Text("ISBN")
                            .font(.headline)
                            .padding(.top, 10)
                        Text("\(data.isbn ?? "N/A")")
                            .onTapGesture(count: 2) {
                                 self.pasteboard.string = self.data.isbn!
                            }
                            .padding(.top, 3)
                    }
                    
                    // Pubished Date
                    if data.publishedDate != nil {
                        Text("Published Date")
                            .font(.headline)
                            .padding(.top, 10)
                        Text("\(data.publishedDate ?? "N/A")")
                            .onTapGesture(count: 2) {
                                 self.pasteboard.string = self.data.publishedDate!
                            }
                            .padding(.top, 3)
                    }
                    
                    // Pages
                     Text("Pages")
                       .font(.headline)
                       .padding(.top, 10)
                    Text("\(data.pageCount)")
                        .onTapGesture(count: 2) {
                             self.pasteboard.string = "\(self.data.pageCount)"
                        }
                       .padding(.top, 3)
                    
                    // Description
                    if data.desc != nil {
                        Text("Description")
                            .font(.headline)
                            .padding(.top, 10)
                        Text("\(data.desc ?? "N/A")")
                            .onTapGesture(count: 2) {
                                 self.pasteboard.string = self.data.desc!
                            }
                            .padding(.top, 3)
                            .lineLimit(nil)
                    }
                }
                
                // Preview
                AsyncImage(
                    url: URL(string: "https://covers.openlibrary.org/b/isbn/\(data.isbn!)-L.jpg")!,
                    // url: URL(string: "https://image.tmdb.org/t/p/original/pThyQovXQrw2m0s9x82twj48Jq4.jpg")!,
                    placeholder: Text("Loading preview..."),
                    cache: self.cache
                )
                .aspectRatio(contentMode: .fit)
                
                // ISBN Barcode
                if data.isbn != nil {
                    VStack {
                       Image(uiImage: UIImage(barcode: data.isbn ?? "") ?? UIImage())
                           .renderingMode(.original)
                           .resizable()
                           .scaledToFit()
                           .border(Color.black, width: 2)
                   }
                   .background(Color.white)
                }
                
                Spacer()
            }
            .navigationBarTitle("Book Details")
            .navigationBarItems(trailing:
                Button(action: {
                     self.showingAlert = true
                })
                {
                    Text("Delete")
                        .foregroundColor(.red)
                }
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("Delete this book?"),
                        message: Text("There is no way back"),
                        primaryButton: .destructive(Text("Delete")) {
                            print("Deleting book \(self.data)")

                            DispatchQueue.main.async {
                                do {
                                    self.managedObjectContext.delete(self.data)
                                    try self.managedObjectContext.save()
                                } catch {
                                    print("Failed to delete book \(self.data)")
                                }

                                self.presentationMode.wrappedValue.dismiss()
                            }

                    }, secondaryButton: .cancel())
                }
            )
            .padding()
        }
    }
}

extension UIImage {
    
    convenience init?(barcode: String) {
        let data = barcode.data(using: String.Encoding.ascii)
        
        guard let filter = CIFilter(name: "CICode128BarcodeGenerator") else {
            return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        
        guard let output = filter.outputImage?.transformed(by: transform) else {
            return nil
        }

        guard let cgImage = CodeRenderer.ciContext.createCGImage(output, from: output.extent) else {
            return nil
        }
        
        self.init(cgImage: cgImage)
    }
    
    
    convenience init?(qrcode: String) {
        let data = qrcode.data(using: String.Encoding.ascii)
        
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else {
            return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        
        guard let output = filter.outputImage?.transformed(by: transform) else {
            return nil
        }

        guard let cgImage = CodeRenderer.ciContext.createCGImage(output, from: output.extent) else {
            return nil
        }
        
        self.init(cgImage: cgImage)
    }
}
