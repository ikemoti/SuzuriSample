//
//  RequestProducts.swift
//  SuzuriSample
//
//  Created by Sousuke Ikemoto on 2020/12/19.
//

import Foundation
import Alamofire

enum RequestProducts: BaseRequestProtocol {
    typealias ResponseType = ProductsResponse

    case get

    var method: HTTPMethod {
        switch self {
        case .get: return .get
        }
    }

    var path: String {
        return APIConstants.xxx.path
    }

    var parameters: Parameters? {
        return nil
    }
}
