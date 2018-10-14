//
//  Result.swift
//  GitHubSearchRepository
//
//  Created by 山下優樹 on 2018/10/14.
//  Copyright © 2018 Yuki Yamashita. All rights reserved.
//

/// エラー処理
/// 成否を表す列挙型
/// 成功時は連想値Tに取得結果を格納し、失敗時は連想値Errorにエラー内容を格納する
enum Result<T, Error: Swift.Error> {
    case success(T)
    case failure(Error)
    
    init(value: T) {
        self = .success(value)
    }
    init(error: Error) {
        self = .failure(error)
    }
}
