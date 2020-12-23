//
//  Product.swift
//  SuzuriSample
//
//  Created by Sousuke Ikemoto on 2020/12/18.
//

import Foundation

public struct ProductsResponse: Codable {
    public let products: [Product]
    public let meta: Meta
    
}

public struct Product: Codable {
    public let id: Int
    public let title: String
    public let published: Bool
    public let publishedAt: String
    public let createdAt: String
    public let updatedAt: String
    public let examplaryAngle: String?
    public let imageUrl: String
    public let sampleImageUrl: URL
    public let url: String
    public let sampleUrl: URL
    public let item: Item
    public let material: Material
}
