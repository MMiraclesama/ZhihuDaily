//
//  commentsViewController.swift
//  新人
//
//  Created by 安宇 on 22/11/2018.
//  Copyright © 2018 安宇. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
import SDWebImage
class CommentsViewController: UIViewController {
    var detailComments: WWelcome!
    var commentsTableView: UITableView!
    override func viewDidLoad() {
        loadComments()
        commentsTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .grouped)
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        navigationItem.title = "详情评论"
        view.addSubview(commentsTableView)
    }
    func loadComments(){
        getCommentsHelper.getcomments(success: { comments in
            self.detailComments = comments
            self.commentsTableView.reloadData()
            
        }, failure: { _ in
            print("??？")
        })
    }
}
extension CommentsViewController:UITableViewDelegate{
    
}
extension CommentsViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if detailComments == nil {
            return 0
        }
        return detailComments.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = CommentsCell()
//        cell.titleLabel1.text = detailComments.comments![indexPath.row].content
//        cell.titleLabel2.text = detailComments.comments![indexPath.row].author
//        return cell
        return CommentsCell(byModel: detailComments, withIndex: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}
