//
//  SearchRepository.swift
//  GitHubSearchRepository
//
//  Created by 山下優樹 on 2018/10/13.
//  Copyright © 2018 Yuki Yamashita. All rights reserved.
//

/// リクエストに対するレスポンスを保持する構造体
/// 検索結果の数と、内容を配列で保持する
/// 内容をジェネリクス<Item>として保有することで、検索対象がリポジトリでもユーザーでもコードでも使い回せる
struct SearchResponse<Item: JSONDecodable>: JSONDecodable {
    let totalCount: Int
    let items: [Item]
    
    
    init(json: Any) throws {
        guard let dictionary = json as? [String : Any] else {
            throw JSONDecodeError.invalidFormat(json: json)
        }
        
        guard let totalCount = dictionary["total_count"] as? Int else {
            throw JSONDecodeError.missingValue(key: "total_count", actualValue: dictionary["total_count"])
        }
        
        guard let itemObject = dictionary["items"] as? [Any] else {
            throw JSONDecodeError.missingValue(key: "items", actualValue: dictionary["items"])
        }
        // 型引数に型制約を追加している(<Item: JSONDecodable>)のでItemのイニシャライザが使える
        let items = try itemObject.map({
            return try Item(json: $0)
        })
        
        self.totalCount = totalCount
        self.items = items
    }
    
}
