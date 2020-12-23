//
//  DescriptionCell.swift
//  SuzuriSample
//
//  Created by Sousuke Ikemoto on 2020/12/23.
//

import UIKit

final class DescriptionCell: UITableViewCell {
    private let titleLabel: UILabel = .init()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI() {
        addSubviews(titleLabel).activateAutoLayout()
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 80),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        titleLabel.text = "仕様・配送について"
        titleLabel.font = .systemFont(ofSize: 20)
    }

}
