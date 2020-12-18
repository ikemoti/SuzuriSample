//
//  CollectionViewController.swift
//  SuzuriSample
//
//  Created by Sousuke Ikemoto on 2020/12/17.
//

import Foundation
import UIKit
import Alamofire

final class CollectionViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        getProduct()
        let flowLayout = UICollectionViewFlowLayout()
        let margin: CGFloat = 5
        flowLayout.itemSize = CGSize(width: 150, height: 250)
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin  
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .white
        
        self.view.addSubviews(collectionView).activateAutoLayout()
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    func getProduct(){
        let apikey = "sya-StGl4wbHoBCMRvp3iBVedVYlS06NZ04B_v5FO9Q"
        let test: HTTPHeaders? = ["Authorization": "Bearer \(apikey)"]
        let url = "https://suzuri.jp/api/v1/products"
//        let para = ["limit": "1"]
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: test ).responseJSON { response  in
            print("テス")
            guard let data = response.data else { return print("return") }
            print("response: \(response)")
            print("data: \(data)")
            print("イエー")
            let user = try! JSONDecoder().decode(Test.self, from: data)
//            print("user: \(String(describing: user))")
            print(user.products.count)
        }
    }
    
}

extension CollectionViewController: UICollectionViewDelegate {}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        return cell
    }
}

