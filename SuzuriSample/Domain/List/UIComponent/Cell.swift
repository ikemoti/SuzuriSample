//
//  Cell.swift
//  SuzuriSample
//
//  Created by Sousuke Ikemoto on 2020/12/17.
//

import Foundation
import UIKit

final class Cell: UICollectionViewCell {
    private let imageView: UIImageView = .init()
    private let titleLabel: UILabel = .init()
    private let subTitleLabel: UILabel = .init()
    private let priceLabel: UILabel = .init()
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.distribution = .fillEqually
        view.axis = .vertical
        view.spacing = 5
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        setAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        self.addSubviews(imageView, stackView).activateAutoLayout()
        stackView.addArrangedSubviews(titleLabel, subTitleLabel, priceLabel).activateAutoLayout()
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    func addContent(product: Product){
        titleLabel.text = product.title
        subTitleLabel.text = product.item.humanizeName
        priceLabel.text = "\(String(product.material.price))円"
        imageView.image = UIImage(named: "nasu")!
        print(product.imageUrl)
        do{
            let imageData = try Data(contentsOf: product.sampleImageUrl)
            imageView.image = UIImage(data: imageData)
        } catch {
            print("Error : Cat't get image")
        }
    }
    private func setAttributes(){
        titleLabel.font = .boldSystemFont(ofSize: 20)
        subTitleLabel.font = .boldSystemFont(ofSize: 20)
        priceLabel.font = .systemFont(ofSize: 20)
        subTitleLabel.textColor = .gray
        titleLabel.textAlignment = .left
        subTitleLabel.textAlignment = .left
        priceLabel.textAlignment = .left
    }
}
