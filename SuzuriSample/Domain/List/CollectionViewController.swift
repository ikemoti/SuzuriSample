//
//  CollectionViewController.swift
//  SuzuriSample
//
//  Created by Sousuke Ikemoto on 2020/12/17.
//

import Foundation
import UIKit
import Alamofire
import RxSwift
import SDWebImage

final class CollectionViewController: UIViewController {
    private let disposeBag = DisposeBag()
    lazy var list: [Product] = []
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let flowLayout = UICollectionViewFlowLayout()
        let itemWidth: CGFloat = CGFloat.getViewWidth()/2 - 20
        let margin: CGFloat = 10
        flowLayout.itemSize = CGSize(width: itemWidth, height: 250)
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin  
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .white
        self.view.addSubviews(collectionView).activateAutoLayout()
        getProduct() { [weak self ] data in
            guard let self = self else { return }
            self.list = data.products
            print(self.list)
            collectionView.reloadData()
           
        }
//        getSaleProduct(){ [weak self ] data in
//            print("終わったよ")
//            guard let self = self else { return }
//            self.list = data.products
//            collectionView.reloadData()
//        }
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 5),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -5)
        ])
    }
    private func getProduct(completion: @escaping (ProductsResponse) -> (Void)){
        let request: RequestProducts = .get
        APICliant.observe(request)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { response in
                completion(response)
                print("suc")
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    private func getSaleProduct(completion: @escaping (ProductsResponse) -> (Void)){
        let request: RequestSaleProducts = .get
        APICliant.observe(request)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { response in
                print("suc")
                completion(response)
            }, onError: { error in
                print("err")
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
}

extension CollectionViewController: UICollectionViewDelegate {}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        cell.addContent(product: list[indexPath.row])
        return cell
    }
}
extension CollectionViewController: UICollectionViewDataSourcePrefetching {
 
    // prefetch開始
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
 
//        // APIなどで取得した画像URLの配列を設定
//        SDWebImagePrefetcher.shared().prefetchURLs(urls)
    }
 
    // prefetchキャンセル
    // スクロールの方向が変更された時に呼ばれる
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
 
        SDWebImagePrefetcher.shared.cancelPrefetching()
    }
}

