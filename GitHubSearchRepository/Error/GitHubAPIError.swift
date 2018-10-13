//
//  GitHubAPIError.swift
//  GitHubSearchRepository
//
//  Created by 山下優樹 on 2018/10/13.
//  Copyright © 2018 Yuki Yamashita. All rights reserved.
//

/// GitHubAPIのエラーレスポンスを保持する構造体
/// エラーレスポンスもJSONなのでJSONDecodableに準拠させる
/// さらにエラーなのでErrorにも準拠させる
struct GitHubAPIError: JSONDecodable, Error {
    
    // ネスト型
    // エラーの詳細メッセージを保持する
    struct FieldError: JSONDecodable {
        let resource: String
        let field: String
        let code: String
        
        init(json: Any) throws {
            guard let dictionary = json as? [String : Any] else {
                throw JSONDecodeError.invalidFormat(json: json)
            }
            
            guard let resource = dictionary["resource"] as? String else {
                throw JSONDecodeError.missingValue(key: "resource", actualValue: dictionary["resource"])
            }
            guard let field = dictionary["field"] as? String else {
                throw JSONDecodeError.missingValue(key: "field", actualValue: dictionary["field"])
            }
            guard let code = dictionary["code"] as? String else {
                throw JSONDecodeError.missingValue(key: "code", actualValue: dictionary["code"])
            }
            
            self.resource = resource
            self.field = field
            self.code = code
        }
    }
    
    // ストアドプロパティ
    let message: String
    let fieldErrors: [FieldError]   // ネスト型で定義したFieldErrorを配列で持つ
    
    init(json: Any) throws {
        guard let dictionary = json as? [String : Any] else {
            throw JSONDecodeError.invalidFormat(json: json)
        }
        
        guard let message = dictionary["message"] as? String else {
            throw JSONDecodeError.missingValue(key: "message", actualValue: dictionary["message"])
        }
        
        // ここでのキャストに失敗した場合は空の配列ができる この場合次のmapでthrowする
        let fieldErrorObject = dictionary["errors"] as? [Any] ?? []
        let fieldErrors = try fieldErrorObject.map({
            return try FieldError(json: $0)
        })
        
        self.message = message
        self.fieldErrors = fieldErrors
        
    }
    
}
