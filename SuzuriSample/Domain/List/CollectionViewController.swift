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
import AlamofireImage

final class CollectionViewController: UIViewController {
    private let disposeBag = DisposeBag()
    lazy var list: [Product] = []
    private var flowLayout = UICollectionViewFlowLayout()
    private let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: .init())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setCollectionView()
        getProduct() { [weak self ] data in
            guard let self = self else { return }
            self.list = data.products
            self.collectionView.reloadData()
            
        }
    }
    
    private func setUI(){
        self.view.addSubviews(collectionView).activateAutoLayout()
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 5),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -5)
        ])
    }
    
    private func setCollectionView(){
        collectionView.frame = view.frame
        collectionView.collectionViewLayout = flowLayout
        let itemWidth: CGFloat = CGFloat.getViewWidth()/2 - 20
        let margin: CGFloat = 10
        flowLayout.itemSize = CGSize(width: itemWidth, height: 250)
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
       
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .white
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let nextVC = segue.destination as! DetailViewController
            nextVC.product = sender as! Product
        }
    }
    
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: list[indexPath.row])
    }
}


extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        let item = list[indexPath.row]
        cell.addContent(product: item)
        cell.isUserInteractionEnabled = true
        return cell
    }
}

