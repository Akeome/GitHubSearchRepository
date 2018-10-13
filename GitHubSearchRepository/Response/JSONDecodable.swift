//
//  JSONDecodable.swift
//  GitHubSearchRepository
//
//  Created by 山下優樹 on 2018/10/13.
//  Copyright © 2018 Yuki Yamashita. All rights reserved.
//

/// イニシャライザでJSONのデコードが必要な型に共通する処理
/// Any型のjsonを引数とし、throwすることを強制できる
protocol JSONDecodable {
    init(json: Any) throws
}
