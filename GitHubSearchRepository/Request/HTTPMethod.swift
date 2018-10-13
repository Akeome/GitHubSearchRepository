//
//  HTTPMethod.swift
//  GitHubSearchRepository
//
//  Created by 山下優樹 on 2018/10/14.
//  Copyright © 2018 Yuki Yamashita. All rights reserved.
//

/// HTTPメソッドの列挙型
/// ローバリューを指定する(:String)ことで、各caseに対応する値を持たせることができる
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case head = "HEAD"
    case delete = "DELETE"
    case patch = "PATCH"
    case trace = "TRACE"
    case options = "OPTIONS"
    case connect = "CONNECT"
}
