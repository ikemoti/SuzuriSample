//
//  RequestChoices.swift
//  SuzuriSample
//
//  Created by Sousuke Ikemoto on 2020/12/21.
//

import Foundation
import Alamofire

enum RequestChoices: BaseRequestProtocol {
    typealias ResponseType = Choices

    case get

    var method: HTTPMethod {
        switch self {
        case .get: return .get
        }
    }

    var path: String {
        return APIConstants.choices.path
    }

    var parameters: Parameters? {
        return nil
    }
}
