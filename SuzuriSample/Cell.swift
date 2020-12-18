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
        //Todo: 後で生成時に追加に修正, forceUnlap
        addContent(title: "タイトル", subTitle: "サブタイトル", price: "値段", image: UIImage(named: "nasu")!)
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
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func addContent(title: String, subTitle: String, price: String, image: UIImage){
        titleLabel.text = title
        subTitleLabel.text = subTitle
        priceLabel.text = price
        imageView.image = image
    }
}
