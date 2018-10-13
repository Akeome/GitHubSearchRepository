//
//  JSONDecodeError.swift
//  GitHubSearchRepository
//
//  Created by 山下優樹 on 2018/10/13.
//  Copyright © 2018 Yuki Yamashita. All rights reserved.
//

/// Any型のJSONをUser型やRepository型に変換する際に起こり得るエラーの種別
/// Errorプロトコルに準拠しているのでthrowされることができる
/// caseの連想値にエラーの詳細を持たせることができる
enum JSONDecodeError: Error {
    /// 構造が期待と異なる
    case invalidFormat(json: Any)
    /// デコード後の構造体の型と異なる、またはキーが存在しない
    case missingValue(key: String, actualValue: Any?)
}
