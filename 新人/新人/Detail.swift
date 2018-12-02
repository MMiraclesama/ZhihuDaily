//
//  detail.swift
//  新人
//
//  Created by 安宇 on 2018/11/11.
//  Copyright © 2018 安宇. All rights reserved.
//

import UIKit
import WebKit
import SDWebImage
import Alamofire
import MJRefresh

class detailController: UIViewController{
    
    
    var image: UIImageView!
    var myNews: Welcomes!
    var newsWebView: WKWebView!
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        newsWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        newsWebView.uiDelegate = self
        view = newsWebView
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetail()
        let rightButton = UIBarButtonItem(title: "评论了解一下", style: .plain, target: self, action: #selector(comments))
        navigationItem.rightBarButtonItem = rightButton
        

    }
    @objc func comments() {
        navigationController?.pushViewController(CommentsViewController(), animated: true)
    }
    
    func loadDetail() {
        detailsNewsHelper.getNews(success: { myNews in
            let htmlString = "<head><link rel=\"stylesheet\" href=\(myNews.css)></head><body>\(myNews.body)</body>"
            self.newsWebView.loadHTMLString(htmlString, baseURL: nil)
            
            
            
        }, failure: { _ in})
    }
 
}
extension detailController: WKUIDelegate{
    
}
