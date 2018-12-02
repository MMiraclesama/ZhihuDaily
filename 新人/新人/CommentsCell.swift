//
//  commentsCell.swift
//  新人
//
//  Created by 安宇 on 22/11/2018.
//  Copyright © 2018 安宇. All rights reserved.
//

import UIKit

class CommentsCell: UITableViewCell {
    
    let titleLabel1 = UILabel()
    let titleLabel2 = UILabel()
    let likesTextField = UITextField()
//    let image = UIImageView()
    let likesLabel = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init() {
        self.init(style: .default, reuseIdentifier: "commentsTableViewCell")
        
        
        titleLabel1.frame = CGRect(x: 40, y: 40, width: UIScreen.main.bounds.width - 60 - 44, height: 44)
        
        contentView.addSubview(titleLabel1)
        titleLabel2.frame = CGRect(x: 40, y: 0, width: UIScreen.main.bounds.width - 60 - 44, height: 44)
        
        contentView.addSubview(titleLabel2)
        
        likesLabel.frame = CGRect(x: 300, y: 10, width: 10, height: 18)

        contentView.addSubview(likesLabel)
        
//        likesTextField.frame = CGRect(x: 100, y: 0, width: 30, height: 30)
    }
    
    convenience init(byModel detailComments: WWelcome, withIndex index: Int) {
        self.init(style: .default, reuseIdentifier: "CommentsCell")
       
        titleLabel1.text = detailComments.comments[index].content
        titleLabel1.frame.origin = CGPoint(x: 40, y: 40)
        titleLabel1.frame.size.width = UIScreen.main.bounds.width - 60 - 44
        
        titleLabel1.lineBreakMode = .byWordWrapping
        titleLabel1.numberOfLines = 0
        titleLabel1.sizeToFit()
        contentView.addSubview(titleLabel1)
        titleLabel2.frame = CGRect(x: 40, y: 0, width: UIScreen.main.bounds.width - 60 - 44, height: 44)
        titleLabel2.text = detailComments.comments[index].author
        contentView.addSubview(titleLabel2)
        
        likesLabel.frame = CGRect(x: 300, y: 10, width: 10, height: 18)
        likesLabel.text = "\(detailComments.comments[index].likes))"
        contentView.addSubview(likesLabel)
        

        
//        detailImageView.frame = CGRect(x: titleLabel.frame.maxX + 20, y: titleLabel.frame.minY, width: 60, height: 60)
//        detailImageView.sd_setImage(with: URL(string: comments.stories![index].images![0]), completed: nil)
//        contentView.addSubview(detailImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

