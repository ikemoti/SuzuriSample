//
//  SemiModalViewController.swift
//  SuzuriSample
//
//  Created by Sousuke Ikemoto on 2020/12/24.
//

import Foundation
import UIKit

public class SemiModalViewController: UIViewController, OverCurrentTransitionable {

    var percentThreshold: CGFloat = 0.3
    var interactor = OverCurrentTransitioningInteractor()

    private var tableViewContentOffsetY: CGFloat = 0.0

    let contentView: UIView = .init()
    let tableView: UITableView = .init()
    let backgroundView: UIView = .init()
  
    
    let labelStackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 20
        return view
    }()
    

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        transitioningDelegate = self
        modalPresentationStyle = .custom
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        transitioningDelegate = self
        modalPresentationStyle = .custom
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        interactor.startHandler = { [weak self] in
            self?.tableView.bounces = false
        }
        interactor.resetHandler = { [weak self] in
            self?.tableView.bounces = true
        }
        setupViews()
    }
    func setLayout(){
        self.view.addSubviews(backgroundView, contentView).activateAutoLayout()
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height/2)
        ])
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.backgroundView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        backgroundView.backgroundColor = .clear
        self.view.backgroundColor = .clear
        contentView.addSubviews(labelStackView).activateAutoLayout()
       
       
      
     
    }

    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8.0
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let headerGesture = UIPanGestureRecognizer(target: self, action: #selector(headerDidScroll(_:)))
        contentView.addGestureRecognizer(headerGesture)

        let gesture = UITapGestureRecognizer(target: self, action: #selector(backgroundDidTap))
        backgroundView.addGestureRecognizer(gesture)

        let tableViewGesture = UIPanGestureRecognizer(target: self, action: #selector(tableViewDidScroll(_:)))
        tableViewGesture.delegate = self
        tableView.addGestureRecognizer(tableViewGesture)
        tableView.delegate = self
        tableView.dataSource = self
    }

    static func make() -> SemiModalViewController {
        let sb = UIStoryboard(name: "SemiModalViewController", bundle: nil)
        let vc = sb.instantiateInitialViewController() as! SemiModalViewController
        
        return vc
    }
   
    @objc private func backgroundDidTap() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func headerDidScroll(_ sender: UIPanGestureRecognizer) {
        interactor.updateStateShouldStartIfNeeded()
        handleTransitionGesture(sender)
    }

    @objc private func tableViewDidScroll(_ sender: UIPanGestureRecognizer) {
        if tableViewContentOffsetY <= 0 {
            interactor.updateStateShouldStartIfNeeded()
        }
        interactor.setStartInteractionTranslationY(sender.translation(in: view).y)
        handleTransitionGesture(sender)
    }
}

extension SemiModalViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tableViewContentOffsetY = scrollView.contentOffset.y
    }
}

extension SemiModalViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
extension SemiModalViewController: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ModalPresentationController(presentedViewController: presented, presenting: presenting)
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }

    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        switch interactor.state {
        case .hasStarted, .shouldFinish:
            return interactor
        case .none, .shouldStart:
            return nil
        }
    }
}
