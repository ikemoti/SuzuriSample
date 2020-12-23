//
//  ProductCell.swift
//  SuzuriSample
//
//  Created by Sousuke Ikemoto on 2020/12/23.
//

import UIKit

final class ProductCell: UITableViewCell {
    private let productImage: UIImageView = .init()
    private let titlelabel: UILabel = .init()
    private let pricelabel: UILabel = .init()
    private let descriptionTitle: UILabel = .init()
    private let descriptionlabel: UILabel = .init()
    private var stackView: UIStackView = {
        let view = UIStackView ()
        view.alignment = .leading
        view.spacing = 10
        view.axis = .vertical
        view.distribution = .equalSpacing
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        addSubviews(productImage,stackView).activateAutoLayout()
        stackView.addArrangedSubviews(titlelabel, pricelabel, descriptionTitle, descriptionlabel).activateAutoLayout()
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: self.topAnchor),
            productImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            productImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: productImage.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    func addContents(product: Product){
        print(product)
        productImage.af.setImage(withURL: product.sampleImageUrl)
        titlelabel.text = product.title
        titlelabel.font = .boldSystemFont(ofSize: 20)
        pricelabel.text = "\(product.material.price)円(税抜き)"
        pricelabel.textColor = UIColor.init(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        descriptionTitle.text = "このアイテムについて"
        descriptionlabel.text = product.material.description
        descriptionlabel.numberOfLines = 0
    }

}
