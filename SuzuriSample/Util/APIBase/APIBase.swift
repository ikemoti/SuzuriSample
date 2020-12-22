//
//  APIBase.swift
//  SuzuriSample
//
//  Created by Sousuke Ikemoto on 2020/12/18.
//
//
import Foundation
import Alamofire
import UIKit
import RxSwift

protocol BaseAPIProtocol {
    associatedtype ResponseType: Decodable

    var method: HTTPMethod { get }
    var baseURL: URL { get }
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var decode: (Data) throws -> ResponseType { get }
}

extension BaseAPIProtocol {

    var baseURL: URL { 
        return try! APIConstants.baseURL.asURL()
    }

    var headers: HTTPHeaders? {
        return APIConstants.header
    }

    var decode: (Data) throws -> ResponseType {
        return { try JSONDecoder().decode(ResponseType.self, from: $0) }
    }
}
protocol BaseRequestProtocol: BaseAPIProtocol, URLRequestConvertible {
    var parameters: Parameters? { get }
    var encoding: URLEncoding { get }
}

extension BaseRequestProtocol {
    var encoding: URLEncoding {
        return URLEncoding.default
    }

    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = headers!
        urlRequest.timeoutInterval = TimeInterval(30)
        if let params = parameters {
            urlRequest = try encoding.encode(urlRequest, with: params)
        }
        return urlRequest
    }
}


enum APIResult {
    case success(Codable)
    case failure(Error)
}

struct APICliant {

    // MARK: Private Static Variables
    private static let successRange = 200..<400
    private static let contentType = ["application/json"]
    static func call<T, V>(_ request: T, _ disposeBag: DisposeBag, onSuccess: @escaping (V) -> Void, onError: @escaping (Error) -> Void)
        where T: BaseRequestProtocol, V: Codable, T.ResponseType == V {

            _ = observe(request)
                .observeOn(MainScheduler.instance)
                .subscribe(onSuccess: { onSuccess($0) },
                           onError: { onError($0) })
                .disposed(by: disposeBag)
    }

    static func observe<T, V>(_ request: T) -> Single<V>
        where T: BaseRequestProtocol, V: Codable, T.ResponseType == V {

            return Single<V>.create { observer in
                let calling = callForData(request) { response in
                    switch response {
                    case .success(let result): observer(.success(result as! V))
                    case .failure(let error): observer(.error(error))
                    }
                }

                return Disposables.create() { calling.cancel() }
            }
    }
    private static func callForData<T, V>(_ request: T, completion: @escaping (APIResult) -> Void) -> DataRequest
        where T: BaseRequestProtocol, V: Codable, T.ResponseType == V {

        return AF.request(request).responseJSON { response in
            switch response.result {
            case .success:
            do {
              if let data = response.data {
                let json = try JSONDecoder().decode(V.self, from: data)
                completion(.success(json))
              } else {
              }
            } catch {
            }
          case let .failure(error):
            completion(.failure(error))
          }
        }
        
  }
    private static func request<T>(_ request: T) -> DataRequest
        where T: BaseRequestProtocol {

            return AF
                .request(request)
                .validate(statusCode: successRange)
                .validate(contentType: contentType)
    }
}


