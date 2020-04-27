//
//  Schema.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

struct BookVolumeInfo: Encodable, Decodable {
    let title: String
    let subtitle: String?
    let description: String?
    let publishedDate: String?
    let pageCount: Int?
    let printType: String?
    let maturityRating: String?
    let allowAnonLogging: Bool?
    let contentVersion: String?
    let language: String?
    let previewLink: String?
    let infoLink: String?
    let canonicalVolumeLink: String?
    
    let authors: [String]
    let categories: [String]?
}

struct BookItem: Encodable, Decodable {
    let kind: String
    let id: String
    let etag: String
    let selfLink: String
    let volumeInfo: BookVolumeInfo
}

struct BookQueryResult: Encodable, Decodable {
    let kind: String
    let totalItems: Int
    let items: [BookItem]
}
