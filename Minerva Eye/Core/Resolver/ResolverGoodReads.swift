//
//  ResolverGoodReads.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 5/8/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import Foundation

class ResolverGoodReads {
    static func fetchBookInfo(isbn: String) -> Void {
        print("THIS IS TEST")
        
        let url = "https://www.goodreads.com/search/index.xml?q=\(isbn)&key="
        let semaphore = DispatchSemaphore(value: 0)
                
        print("Calling GoodReads Books API - ISBN: \(isbn)")
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            if let error = error {
                print("GoodReads API failed - ISBN: \(isbn), error: \(error)")
                //result = .failure(.wrongResponse)
            }
            
            if let data = data {
                let xml = String(decoding: data, as: UTF8.self)
                print("GoodReads API returned data - \(xml)")
                
                do {
                    let res = try XMLParser(data: data)
                    print(res.parse())
                    
//                    if(!res.items.isEmpty) {
//                        let book = res.items[0]
//                        self.cache[isbn] = book
//                        result = .success(book)
//                    }
                } catch  {
                    print("Unable to decode GoodReads API response - ISBN: \(isbn)")
//                    result = .failure(.wrongResponse)
                }
            }
            
            semaphore.signal()
        }.resume()
                
        _ = semaphore.wait(wallTimeout: .distantFuture)
        
    }
}
