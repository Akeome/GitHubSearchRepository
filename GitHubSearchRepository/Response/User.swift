//
//  User.swift
//  GitHubSearchRepository
//
//  Created by 山下優樹 on 2018/10/13.
//  Copyright © 2018 Yuki Yamashita. All rights reserved.
//

/// ユーザー型
struct User: JSONDecodable {
    // ストアドプロパティ
    // これらの値は必須なのでオプショナルにしていない
    let id: Int
    let login: String
    
    // イニシャライザ
    // Any型であるJSONから自身のプロパティに合わせてデコードする
    init(json: Any) throws {
        // まずjsonから [String : Any]のDictionary型の変数を生成
        guard let dictionary = json as? [String : Any] else {
            throw JSONDecodeError.invalidFormat(json: json)
        }
        
        // 生成したdictionaryから期待する値を取り出す
        guard let id = dictionary["id"] as? Int else {
            throw JSONDecodeError.missingValue(key: "id", actualValue: dictionary["id"])
        }
        guard let login = dictionary["login"] as? String else {
            throw JSONDecodeError.missingValue(key: "login", actualValue: dictionary["login"])
        }
        
        // 取り出した値を自身のプロパティに格納
        self.id = id
        self.login = login
    }
}
