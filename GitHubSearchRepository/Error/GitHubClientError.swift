//
//  GitHubClientError.swift
//  GitHubSearchRepository
//
//  Created by 山下優樹 on 2018/10/13.
//  Copyright © 2018 Yuki Yamashita. All rights reserved.
//

/// APIクライアントで起こりうるエラーの列挙型
/// 各caseにErrorプロトコルに準拠した連想値を持たせて、詳細なエラーを判別できるようにしている
enum GitHubClientError: Error {
    // 通信に失敗
    case connectionError(Error)
    // レスポンスの解釈に失敗
    case responseParseError(Error)
    // APIからエラーレスポンスを受け取った
    case apiError(GitHubAPIError)
    
}
