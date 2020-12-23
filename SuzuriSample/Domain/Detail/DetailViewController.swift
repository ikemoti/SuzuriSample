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
    }
}

extension DetailViewController{
    private func setUI(){
        self.view.addSubviews(tableView).activateAutoLayout()
        
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
        
    }
    
    
}
