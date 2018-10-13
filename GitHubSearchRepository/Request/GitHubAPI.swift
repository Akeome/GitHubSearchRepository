//
//  SearchRepositories.swift
//  GitHubSearchRepository
//
//  Created by 山下優樹 on 2018/10/14.
//  Copyright © 2018 Yuki Yamashita. All rights reserved.
//


/// リクエストを表す型をグルーピングするクラス
/// グルーピングすることで呼び出し側ではGitHubAPI.SearchRepositoriesと表記することになるため、リクエストの種類が一目瞭然
final class GitHubAPI {
    /// リポジトリの検索
    struct SearchRepositories: GitHubRequest {
        // 検索ワード 初期値を与えないのでイニシャライザで必ず入力させることができる
        let keyword: String
        
        // GitHubRequestで要求する連想型
        typealias Response = SearchResponse<Repository>
        
        // GitHubRequestで要求するプロパティたち
        var method: HTTPMethod {
            return .get
        }
        var path: String {
            return "/search/repositories"
        }
        var parameters: Any? {
            return ["q" : keyword]
        }
        
    }
    
    // ユーザーの検索
    struct SearchUsers: GitHubRequest {
        // 検索ワード 初期値を与えないのでイニシャライザで必ず入力させることができる
        let keyword: String
        
        // GitHubRequestで要求する連想型
        typealias Response = SearchResponse<User>
        
        // GitHubRequestで要求するプロパティたち
        var method: HTTPMethod {
            return .get
        }
        var path: String {
            return "/search/repositories"
        }
        var parameters: Any? {
            return ["q" : keyword]
        }
        
    }
}
