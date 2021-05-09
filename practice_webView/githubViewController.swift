//
//  githubViewController.swift
//  practice_webView
//
//  Created by 이병훈 on 2021/05/09.
//

import UIKit
import WebKit

class githubViewController: UIViewController {
    //2
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.navigationDelegate = self
        
        //2
        let blog = "https://ghu"
        if let url = URL(string: blog) {
            let req = URLRequest(url: url)
            self.webView.load(req)
        } else {
            NSLog("url error")
            
        }
        //3
    }
}

extension githubViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let warrning = UIAlertController(title: "경고", message: "없는 URL입니다.", preferredStyle: .alert)
        
        warrning.addTextField(){(tf) in
            tf.placeholder = "url을 다시 입력하세요"
            tf.borderStyle = .roundedRect
        }
        let ok = UIAlertAction(title: "ok", style: .default){ _ in
            guard let reUrlText = warrning.textFields?[0].text else{
                return
            }
            if let reUrl = URL(string: reUrlText) {
                let request = URLRequest(url: reUrl)
                self.webView.load(request)
            }
            
        }
    let cancel = UIAlertAction(title: "cancel", style: .cancel){ _ in
        
        self.navigationController?.popViewController(animated: true)
        
    }
    warrning.addAction(cancel)
    
    warrning.addAction(ok)
        
        self.present(warrning, animated: false)
  }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.indicatorView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.indicatorView.stopAnimating()
    }
}
