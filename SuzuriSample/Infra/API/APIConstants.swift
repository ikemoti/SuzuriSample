//
//  APIConstants.swift
//  SuzuriSample
//
//  Created by Sousuke Ikemoto on 2020/12/21.
//

import Foundation
import Alamofire

enum APIConstants {
    case xxx
    case saleProduct
    case choices
    public var path: String {
        switch self {
        case .xxx: return "/api/v1/products"
        case .saleProduct: return "/api/v1/products/on_sale"
            case .choices: return "/api/v1/choices"
        }
    }
    public static var baseURL = "https://suzuri.jp"

    public static var header: HTTPHeaders? {
        return [
            "Authorization": "Bearer sya-StGl4wbHoBCMRvp3iBVedVYlS06NZ04B_v5FO9Q"
        ]
    }
}
