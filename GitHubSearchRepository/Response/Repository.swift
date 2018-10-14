//
//  Repository.swift
//  GitHubSearchRepository
//
//  Created by 山下優樹 on 2018/10/13.
//  Copyright © 2018 Yuki Yamashita. All rights reserved.
//

/// リポジトリ型
struct Repository: JSONDecodable {
    // ストアドプロパティ
    let id: Int
    let name: String
    let fullName: String
    // リポジトリ毎にユーザー型のオーナーを持つ
    let owner: User
    
    // イニシャライザ
    // JSONDecodableに準拠することで実装が強制される
    init(json: Any) throws {
        // まずdictionaryにデコード
        guard let dictionary = json as? [String : Any] else {
            throw JSONDecodeError.invalidFormat(json: json)
        }
        
        // dictionaryから値取得
        guard let id = dictionary["id"] as? Int else {
            throw JSONDecodeError.missingValue(key: "id", actualValue: dictionary["id"])
        }
        guard let name = dictionary["name"] as? String else {
            throw JSONDecodeError.missingValue(key: "name", actualValue: dictionary["name"])
        }
        guard let fullName = dictionary["full_name"] as? String else {
            throw JSONDecodeError.missingValue(key: "full_name", actualValue: dictionary["full_name"])
        }
        // User型を取得したいがあえて as? User とせずAny型を取得
        guard let ownerObject = dictionary["owner"] else {
            throw JSONDecodeError.missingValue(key: "owner", actualValue: dictionary["owner"])
        }
        
        self.id = id
        self.name = name
        self.fullName = fullName
        // ここでUserのイニシャライザを利用してAny型からUser型にする
        // do-catchなしでtryできるのはこのイニシャライザがthrowsだから。tryが失敗すればUser.initがthrowするエラーがRepository.initのエラーになる
        self.owner = try User(json: ownerObject)
        
    }
    
}
