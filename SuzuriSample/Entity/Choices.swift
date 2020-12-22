//
//  Choices.swift
//  SuzuriSample
//
//  Created by Sousuke Ikemoto on 2020/12/21.
//

import Foundation

public struct Choices: Codable {
    public let choices: [Choice]
    public let meta: Meta
}
public struct Choice: Codable {
    public let id: Int
    public let title: String
    public let description: String
    public let secret: Bool
    public let bannerUrl: URL
    public let productsCount: Int
    public struct User: Codable {
        public let id: Int
        public let name: String
        public let displayName: String
        public let avatarUrl: URL
    }
    public let user: User
}
