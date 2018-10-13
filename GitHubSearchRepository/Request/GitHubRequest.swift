//
//  GitHubRequest.swift
//  GitHubSearchRepository
//
//  Created by 山下優樹 on 2018/10/14.
//  Copyright © 2018 Yuki Yamashita. All rights reserved.
//

// URLを扱うため必要
import Foundation

/// リクエストに必要な要素をプロトコルに持たせる
protocol GitHubRequest {
    // 連想型 プロトコル準拠側で型を指定できる(させる)
    // リクエストに対するレスポンスをここに保持する
    associatedtype Response: JSONDecodable
    
    // 呼び出し側からURLを変更することはありえないのでgetのみ
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    // GETのときは[String:String]、POSTのときはAny(JSON)、パラメータ不要のときはnil、よってAny?型としている
    var parameters: Any? { get }
}

/// プロトコルエクステンションで規定することで一元管理できる、繰り返しの記述を省略できる
extension GitHubRequest {
    var baseURL: URL {
        get {
            return URL(string: "https://api.github.com")!
        }
    }
    
    // HTTP通信を行うURLRequestに対応するためのメソッド
    // GitHubRequestが保持するプロパティを使ってURLRequestを組み立てる
    func buildURLRequest() -> URLRequest {
        // baseURLとpathの統合
        let url = baseURL.appendingPathComponent(path)
        // 上記からURLComponentsの生成
        let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true)
        
        switch method {
        case .get:
            let dictionary = parameters as? [String : Any]
            let queryItems = dictionary?.map({ key, value in
                return URLQueryItem(name: key, value: String(describing: value))
            })
            // エンコードのための設定
            components?.queryItems = queryItems
            
        default:
            // get以外はプログラムを終了する
            fatalError("Unsupported method \(method)")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.url = components?.url
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
}
