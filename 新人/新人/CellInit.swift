//
//  cellInit.swift
//  新人
//
//  Created by 安宇 on 2018/11/12.
//  Copyright © 2018 安宇. All rights reserved.
//

import UIKit

class newsCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let newsImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init() {
        self.init(style: .default, reuseIdentifier: "newsTableViewCell")
        
        
        titleLabel.frame = CGRect(x: 20, y: 20, width: UIScreen.main.bounds.width - 60 - 44, height: 44)
      
        contentView.addSubview(titleLabel)
        
        newsImageView.frame = CGRect(x: titleLabel.frame.maxX + 20, y: titleLabel.frame.minY, width: 44, height: 44)
        //newsImageView.sd_setImage(with: URL(string: lastestNews.stories[index].images![0]), completed: nil)
        contentView.addSubview(newsImageView)
    }
    
    convenience init(byModel news: Welcome, withIndex index: Int) {
        self.init(style: .default, reuseIdentifier: "newsTableViewCell")
        
        
        titleLabel.frame = CGRect(x: 20, y: 20, width: UIScreen.main.bounds.width - 60 - 44, height: 44)
        titleLabel.text = news.stories[index].title
        contentView.addSubview(titleLabel)
        
        newsImageView.frame = CGRect(x: titleLabel.frame.maxX + 20, y: titleLabel.frame.minY, width: 60, height: 60)
        newsImageView.sd_setImage(with: URL(string: news.stories[index].images![0]), completed: nil)
        contentView.addSubview(newsImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

