//
//  NewProduct.swift
//  SuzuriSample
//
//  Created by Sousuke Ikemoto on 2020/12/18.
//

import Foundation

public struct Material: Codable {
    public let id: Int
    public let title: String
    public let description: String?
    public let price: Int
    public let violation: Bool
    public let published: Bool
    public let publishedAt: String?
    public let uploadedAt: String
    public let dominantRgb: String?
    public let originalWidth: Int
    public let originalHeight: Int
    public let user: User
}

public struct User: Codable {
    public let id: Int
    public let name: String
    public let displayName: String?
    public let avatarUrl: URL?
}
public struct SampleItemVariant: Codable {
    public let id: Int
    public let price: Int
    public let exemplary: Bool
    public let enabled: Bool
    public let isLightColor: Bool
    public let isDarkColor: Bool
    let color: Color
    public let size: Size
    public let printPlaces: [PrintPlace]
}

public struct Color: Codable {
    public let id: Int
    public let name: String
    public let displayName: String
    public let rgb: String
}

public struct Size: Codable {
    public let id: Int
    public let name: String
    public let displayName: String
}

public struct PrintPlace: Codable {
    public let id: Int
    public let place: String
    public let price: Int
    public let itemVariantId: Int
}
public struct Meta: Codable {
        public let hasNext: Bool
    }
public struct IconUrls: Codable {
                public let blackSvg: String
                public let whiteSvg: String
                public let blackPng: String
                public let whitePng: String
            }

public struct PrintPlaceDisplayNames: Codable {
                public let front: String
                public let back: String
            }
public struct PrintPlaceForExtraAngles: Codable {
                public struct TShirt: Codable {
                    public let frontWearingMens: String
                    public let frontWearingLadies: String
                    private enum CodingKeys: String, CodingKey {
                        case frontWearingMens = "front-wearing-mens"
                        case frontWearingLadies = "front-wearing-ladies"
                    }
                }
                public let tShirt: TShirt
                private enum CodingKeys: String, CodingKey {
                    case tShirt = "t-shirt"
                }
            }
public struct ProductImageUrlTemplates: Codable {
                public let front: String
            }

public struct Item: Codable {
    public let id: Int
    public let name: String
    public let angles: [String?]
    public let humanizeName: String
    public let availablePrintPlaces: [String]
    public let defaultPrintPlace: String
    public let displayOrder: Int
    public let essentialAngles: [String]
    public let extraAngles: [String]
    public let iconUrls: IconUrls
    public let isMultiPrintable: Bool
    public let printPlaceDisplayNames: PrintPlaceDisplayNames
    
    public let printPlaceForExtraAngles: PrintPlaceForExtraAngles
    public let imageDescriptions: [String]
    
    public let productImageUrlTemplates: ProductImageUrlTemplates
}
