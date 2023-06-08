//
//  ViewController.swift
//  
//  
//  Created by ji-no on 2023/06/08
//  
//

import UIKit
import WebKit
import RxSwift
import RxWebKit

class ViewController: UIViewController {
    private lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        configuration.websiteDataStore = WKWebsiteDataStore.default()
        return WKWebView(frame: .zero, configuration: configuration)
    }()

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        setUpRx()
        
        let url = URL(string: "https://newrelic.com/")!
        let req = URLRequest(url: url)
        self.webView.load(req)
    }

    func setUpRx() {
        webView.rx.decidePolicyNavigationAction
            .debug("decidePolicyNavigationAction")
            .subscribe(onNext: { event in
                event.handler(.allow)
            })
            .disposed(by: disposeBag)
    }

}

