//
//  Resolver.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import Foundation

class Resolver {
    // static private var cache: [String: BookItem] = [:]
    
    enum LookupError: Error {
        case wrongRequest
        case wrongResponse
    }
    
    static func fetchBookInfo(isbn: String) -> Result<BookItem?, LookupError> {
        let path = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)&key="
        guard let url = URL(string: path) else {
            return .failure(.wrongRequest)
        }
        
        var result: Result<BookItem?, LookupError>!
        
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
//            print(data)
//            print(response)
//            print(error)
            
            if let _ = error {
                result = .failure(.wrongResponse)
            }
            
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(BookQueryResult.self, from: data)
                    if(!res.items.isEmpty) {
                        let book = res.items[0]
                        result = .success(book)
                    }
                    
                } catch {
                    result = .failure(.wrongResponse)
                }
            }
            
            semaphore.signal()
        }.resume()
        
        _ = semaphore.wait(wallTimeout: .distantFuture)
        
        return result
    }
}
