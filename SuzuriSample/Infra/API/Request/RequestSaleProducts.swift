//
//  RequestSaleProducts.swift
//  SuzuriSample
//
//  Created by Sousuke Ikemoto on 2020/12/21.
//

import Foundation
import Alamofire

enum RequestSaleProducts: BaseRequestProtocol {
    typealias ResponseType = ProductsResponse

    case get

    var method: HTTPMethod {
        switch self {
        case .get: return .get
        }
    }

    var path: String {
        return APIConstants.saleProduct.path
    }

    var parameters: Parameters? {
        return nil
    }
}
