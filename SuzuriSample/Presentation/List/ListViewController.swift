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
import RxCocoa

final class ListViewController: UIViewController {
    private let disposeBag = DisposeBag()
    lazy var list: [Product] = []
    private var flowLayout = UICollectionViewFlowLayout()
    private let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: .init())
    private let searchButton: UIButton = .init()
    private let bottomView: UIView = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        getProduct() { [weak self ] data in
            guard let self = self else { return }
            self.list = data.products
            self.collectionView.reloadData()
        }
        setUI()
        searchButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            let vc = SemiModalViewController.make()
            self.present(vc, animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
    }
    
    private func setUI(){
        self.view.addSubviews(collectionView,bottomView).activateAutoLayout()
        bottomView.addSubviews(searchButton).activateAutoLayout()
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 5),
        ])
      
        searchButton.backgroundColor = .blue
        bottomView.backgroundColor = .green

        
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            bottomView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 80),
        ])
        NSLayoutConstraint.activate([
            searchButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            searchButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            searchButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            searchButton.widthAnchor.constraint(equalToConstant: 40)
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

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: list[indexPath.row])
    }
}


extension ListViewController: UICollectionViewDataSource {
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
