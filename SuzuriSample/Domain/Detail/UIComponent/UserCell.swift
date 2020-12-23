//
//  UserCell.swift
//  SuzuriSample
//
//  Created by Sousuke Ikemoto on 2020/12/23.
//

import UIKit

final class UserCell: UITableViewCell {
    private let titleLabel: UILabel = .init()
    private let iconImageView: EnhancedCircleImageView = .init()
    private let nameLabel: UILabel = .init()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        addSubviews(titleLabel,iconImageView,nameLabel).activateAutoLayout()
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            iconImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10),
            iconImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10),
            iconImageView.heightAnchor.constraint(equalToConstant: 60),
            iconImageView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.iconImageView.trailingAnchor,constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            nameLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor),
            nameLabel.heightAnchor.constraint(equalTo: iconImageView.heightAnchor)
        
        ])
    }
    func addContents(product: Product){
        titleLabel.text = "作った人"
        nameLabel.text = "\(product.material.user.displayName ?? "アバター名なし")(ID:\(product.material.user.name))"
        iconImageView.af.setImage(withURL: product.material.user.avatarUrl!)
    }
    
}
