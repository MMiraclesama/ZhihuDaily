//
//  ViewController.swift
//  新人
//
//  Created by 安宇 on 2018/11/10.
//  Copyright © 2018 安宇. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import MJRefresh

class ViewController: UIViewController {

    var news: Welcome!
    var dailyNewsTableView = UITableView()
    let scrollView = UIScrollView(frame: CGRect(x: 0, y: 80, width: UIScreen.main.bounds.width, height: 200))
    var pageController: UIPageControl!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

        
        //dailyNewsTableView = UITableView.init(frame: CGRect(x: 0, y: 300, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 600), style: .grouped)
        dailyNewsTableView.frame = view.bounds
        dailyNewsTableView.delegate = self
        dailyNewsTableView.dataSource = self
        navigationItem.title = "今日趣闻"
        let leftButton = UIBarButtonItem( barButtonSystemItem: .play, target: self, action: #selector(detail))
        navigationItem.leftBarButtonItem = leftButton
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * 3, height: 300)
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = true
        scrollView.bounces = false
        

        dailyNewsTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {self.dailyNewsTableView.mj_header.beginRefreshing()

//        self.dailyNewsTableView.mj_header.setTitle("下拉可以刷新", for: .idle)
//            self.mj_header.setTitle("释放实现刷新", for: .pulling)
            self.dailyNewsTableView.reloadData()
        self.dailyNewsTableView.mj_header.endRefreshing()
        })
        

    
        
        
        view.addSubview(dailyNewsTableView)
        //view.addSubview(scrollView)
//        scrollView.addGestureRecognizer(tap)
        dailyNewsTableView.tableHeaderView = scrollView
    }

    @objc func detail() {

    }
    func loadData(){
        LastestNewsHelper.getLastestNews(success: { news in
            self.news = news
            self.dailyNewsTableView.reloadData()
            self.addImage()

        }, failure: { _ in
            print("??？")
            })
    }


    func addImage() {
        for i in 0..<3 {
//            let imageView = UIImageView(frame: CGRect(x: Int(UIScreen.main.bounds.width) * i, y: 0, width: Int(UIScreen.main.bounds.width), height: 300))
//            imageView.sd_setImage(with: URL(string: news.stories![i].images![0]), completed: nil)
//            self.scrollView.addSubview(imageView)
            let button = UIButton(frame: CGRect(x: Int(UIScreen.main.bounds.width) * i, y: 0, width: Int(UIScreen.main.bounds.width), height: 300))
            button.sd_setBackgroundImage(with: URL(string: news.stories[i].images![0]), for: .normal, completed: nil)
            button.tag = news.stories[i].id
            button.addTarget(self, action: #selector(clickImageButton), for: .touchUpInside)
            self.scrollView.addSubview(button)
        }
    }
    
    @objc func clickImageButton(button: UIButton) {
        NewsID.id = button.tag
        navigationController?.pushViewController(detailController(), animated: true)
    }
    




}
extension ViewController: UITableViewDelegate{

    
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if news == nil {
            return 0
        }
        return news.stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsCell()
        cell.titleLabel.text = news.stories[indexPath.row].title
        cell.newsImageView.sd_setImage(with: URL(string: news.stories[indexPath.row].images![0]))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NewsID.id = news.stories[indexPath.row].id
        navigationController?.pushViewController(detailController(), animated: true)
    }
    
}


