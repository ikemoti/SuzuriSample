//
//  DetailViewController.swift
//  SuzuriSample
//
//  Created by Sousuke Ikemoto on 2020/12/22.
//

import UIKit

enum CellClass {
    case product
    case delivery
    case user
}

class DetailViewController: UIViewController {
    var product: Product?
    private let imageView: UIImageView = .init()
    private let titlelabel: UILabel = .init()
    private let tableView: UITableView = .init()
    private var section: [CellClass] = [.product, .delivery, .user]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setUI()

    }
    private func setTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductCell.self, forCellReuseIdentifier: "product")
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: "description")
        tableView.register(UserCell.self, forCellReuseIdentifier: "user")
        tableView.backgroundColor = UIColor(red: 239 / 255, green: 239 / 255, blue: 244 / 255, alpha: 1)
    }
}

extension DetailViewController{
    private func setUI(){
        self.view.addSubviews(tableView).activateAutoLayout()
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        ])
    }
}

extension DetailViewController: UITableViewDelegate {
    
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return section.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product") as! ProductCell
        cell.addContents(product: product!)
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let marginView = UIView()
        marginView.backgroundColor = .clear
        return marginView
    }
}
