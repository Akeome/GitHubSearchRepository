//
//  GitHubClient.swift
//  GitHubSearchRepository
//
//  Created by 山下優樹 on 2018/10/14.
//  Copyright © 2018 Yuki Yamashita. All rights reserved.
//

import Foundation

/// リクエストを受け取って通信を行い、レスポンスを解釈するまでの流れを管理するクラス
class GitHubClient {
    // sessionのインスタンスは使い回すのでストアドプロパティとして保持
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    
    // リクエストの送信 結果を非同期的に通知
    // 第1引数に渡す型が保持する連想型が、resultの型を決める
    func send<Request: GitHubRequest> (
        request: Request,
        complation: @escaping (Result<Request.Response, GitHubClientError>) -> Void) {
        
        let urlRequest = request.buildURLRequest()
        let task = session.dataTask(with: urlRequest) {
            data, response, error in    // 通信結果はこの3つのクロージャの引数から判別する
            
            switch (data, response, error) {
            case (_, _, let error?):    // errorがnilでなければ通信に失敗
                // Resultのイニシャライザはinit(value: T)かinit(error: Error)のどちらか この場合エラーなので後者を使う
                complation(Result(error: .connectionError(error)))
                
            case (let data?, let response?, _): // dataとresponseがnilでなければ通信に成功
                do {
                    let response = try request.response(from: data, urlResponse: response)
                    // Resultのイニシャライザ init(value: T)を使う
                    complation(Result(value: response))
                } catch let error as GitHubAPIError {
                    complation(Result(error: .apiError(error)))
                } catch {
                    complation(Result(error: .responseParseError(error)))
                }
                
            default: // このケースはURLSettionの実装的にありえないので考慮する必要はない
                // switchの網羅性を満たすため、またこの分岐に到達しないことを明示的にするためfatalErrorを使う
                fatalError("invalid response combination \(data), \(response), \(error).")
                
            }
            
        }
        
        // 通信の開始
        task.resume()
    }
    
}
