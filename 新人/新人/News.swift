//
//  news.swift
//  新人
//
//  Created by 安宇 on 2018/11/11.
//  Copyright © 2018 安宇. All rights reserved.
//

import Foundation
import Alamofire

struct NewsHelper {
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

struct LastestNewsHelper {
    static func getLastestNews(success: @escaping (Welcome)->(), failure: @escaping (Error)->()) {
        NewsHelper.dataManager(url: "https://news-at.zhihu.com/api/4/news/latest", success: { dic in
            if let data = try? JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.init(rawValue: 0)), let welcome = try? Welcome(data: data) {
                success(welcome)
            }
        }, failure: { _ in
            
        })
    }
}
// Mark: Model???
struct Welcome: Codable {
    let date: String
//    下面问号
    let stories: [Story]
    let topStories: [TopStory]
    
    enum CodingKeys: String, CodingKey {
        case date, stories
        case topStories = "top_stories"
    }
}

struct Story: Codable {
    let images: [String]?
    let type, id: Int
    let gaPrefix, title: String
    let multipic: Bool?
    
    enum CodingKeys: String, CodingKey {
        case images, type, id
        case gaPrefix = "ga_prefix"
        case title, multipic
    }
}

struct TopStory: Codable {
    let image: String?
    let type, id: Int?
    let gaPrefix, title: String?

    enum CodingKeys: String, CodingKey {
        case image, type, id
        case gaPrefix = "ga_prefix"
        case title
    }
    
}

// MARK: Convenience initializers and mutators

extension Welcome {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Welcome.self, from: data)
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
        date: String? = nil,
        stories: [Story]? = nil,
        topStories: [TopStory]? = nil
        ) -> Welcome {
        return Welcome (
            date: date ?? self.date,
            stories: stories ?? self.stories,
            topStories: topStories ?? self.topStories
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Story {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Story.self, from: data)
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
        images: [String]?? = nil,
        type: Int? = nil,
        id: Int? = nil,
        gaPrefix: String? = nil,
        title: String? = nil,
        multipic: Bool?? = nil
        ) -> Story {
        return Story(
            images: images ?? self.images,
            type: type ?? self.type,
            id: id ?? self.id,
            gaPrefix: gaPrefix ?? self.gaPrefix,
            title: title ?? self.title,
            multipic: multipic ?? self.multipic
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension TopStory {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TopStory.self, from: data)
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
        image: String?? = nil,
        type: Int?? = nil,
        id: Int?? = nil,
        gaPrefix: String?? = nil,
        title: String?? = nil
        ) -> TopStory {
        return TopStory(
            image: image ?? self.image,
            type: type ?? self.type,
            id: id ?? self.id,
            gaPrefix: gaPrefix ?? self.gaPrefix,
            title: title ?? self.title
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

