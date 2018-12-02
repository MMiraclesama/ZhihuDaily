//
//  CommentsData.swift
//  新人
//
//  Created by 安宇 on 22/11/2018.
//  Copyright © 2018 安宇. All rights reserved.
//

import Foundation
import Alamofire
struct CommentsHelper {
    static func dataManager(url: String, success: (([String: Any])->())? = nil, failure: ((Error)->())? = nil) {
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.result.value  {
                    if let dict = data as? [String: Any] {
                        success?(dict)
                    }
                }
            case .failure(let error):
                failure?(error)
                if let data = response.result.value  {
                    if let dict = data as? [String: Any],
                        let errmsg = dict["message"] as? String {
                        print(errmsg)
                    }
                } else {
                    print(error)
                }
            }
        }
    }
}

struct getCommentsHelper {
    static func getcomments(success: @escaping (WWelcome)->(), failure: @escaping (Error)->()) {
        detailNewsHelper.dataManager(url: "https://news-at.zhihu.com/api/4/news/\(NewsID.id)/comments", success: { dic in
            if let data = try? JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.init(rawValue: 0)), let wwelcome = try? WWelcome(data: data) {
                success(wwelcome)
            }
        }, failure: { _ in
            
        })
    }
}
struct WWelcome: Codable {
    let comments: [Comment]
}

struct Comment: Codable {
    let author, content: String
    let avatar: String
    let time, id, likes: Int
}

// MARK: Convenience initializers and mutators

extension WWelcome {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(WWelcome.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        comments: [Comment]? = nil
        ) -> WWelcome {
        return WWelcome(
            comments: comments ?? self.comments
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Comment {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Comment.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        author: String? = nil,
        content: String? = nil,
        avatar: String? = nil,
        time: Int? = nil,
        id: Int? = nil,
        likes: Int? = nil
        ) -> Comment {
        return Comment(
            author: author ?? self.author,
            content: content ?? self.content,
            avatar: avatar ?? self.avatar,
            time: time ?? self.time,
            id: id ?? self.id,
            likes: likes ?? self.likes
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
