//
//  ViewController.swift
//  practice_webView
//
//  Created by 이병훈 on 2021/05/06.
//

import UIKit
//1
import WebKit

class blogViewController: UIViewController {
    //2
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.navigationDelegate = self
        //2
        let blog = "https://boidevelop.tistory.com"
        if let url = URL(string: blog) {
            let req = URLRequest(url: url)
            self.webView.load(req)
        } else {
            NSLog("url error")
        }
        //3
        self.navigationItem.title = "HooniOS 블로그임돠~"
    }

}

extension blogViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let warrning = UIAlertController(title: "경고", message: "없는 URL입니다.", preferredStyle: .alert)
        
        warrning.addTextField(){(tf) in
            tf.placeholder = "url을 다시 입력하세요"
            tf.borderStyle = .roundedRect
        }
        let cancel = UIAlertAction(title: "ok", style: .default){ _ in
            guard let reUrlText = warrning.textFields?[0].text else{
                return
            }
            if let reUrl = URL(string: reUrlText) {
                let request = URLRequest(url: reUrl)
                self.webView.load(request)
            }
            
        }
        warrning.addAction(cancel)
        
        self.present(warrning, animated: false)
    
  }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.loadingView.isHidden = false
        self.loadingView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.loadingView.isHidden = true
        self.loadingView.stopAnimating()
    }
}
