//
//  ListModel.swift
//  SuzuriSample
//
//  Created by Sousuke Ikemoto on 2020/12/22.
//
import Foundation
import RxSwift

protocol ListModelProtocol {
    func getList(completion: @escaping (ProductsResponse) -> (Void))
//    func serachList() -> Observable<[Product]>
}

class ListModel: ListModelProtocol {
    private let disposebag: DisposeBag = .init()
    func getList(completion: @escaping (ProductsResponse) -> (Void)) {
        let request: RequestProducts = .get
        APICliant.observe(request)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { response in
                completion(response)
                print("suc")
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposebag)
    }
}
