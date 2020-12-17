//
//  WebVC.swift
//  SuzuriSample
//
//  Created by Sousuke Ikemoto on 2020/12/17.
//

import Foundation
import WebKit
import OAuthSwift

class OAuthWebVC: OAuthWebViewController, WKNavigationDelegate {

    var targetURL: URL?
    let webView = WKWebView()
    var cancelBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)
//        cancelBtn = NSButton(title: "Cancel", target: self, action: #selector(cancel))
        cancelBtn.setTitle("キャンセル", for: .normal)
        
        cancelBtn!.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cancelBtn)

        webView.leadingAnchor.constraint(equalTo:  self.view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo:  self.view.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo:  self.view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40.0).isActive = true
        cancelBtn!.widthAnchor.constraint(equalToConstant: 82.0).isActive = true
        cancelBtn!.heightAnchor.constraint(equalToConstant: 32.0).isActive = true
        cancelBtn!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        cancelBtn!.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20.0).isActive = true
    }

    override func handle(_ url: URL) {
        targetURL = url
        super.handle(url)
        self.loadAddressURL()
    }

    func loadAddressURL() {
        guard let url = targetURL else {
            return
        }
        let req = URLRequest(url: url)
        webView.load(req)
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            if url.host == "oauth-callback" {
                OAuthSwift.handle(url: url)
                decisionHandler(WKNavigationActionPolicy.cancel)
                self.dismissWebViewController()
                return
            }
        }
        decisionHandler(WKNavigationActionPolicy.allow)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        Swift.print(error.localizedDescription)
        self.dismissWebViewController()
    }

    @objc func cancel() {
        self.dismissWebViewController()
    }

}
