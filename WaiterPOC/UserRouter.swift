//
//  UserRouter.swift
//  Waiter
//
//

import Foundation
import Alamofire

enum UserRouter: URLRequestConvertible {
    static let baseURLString = "http://127.0.0.1:5000"
    
    case Subscribe([String: AnyObject])
    case Login([String: AnyObject])
    case UserInfo(String, String)
    case UserProfile(String, String, [String: AnyObject])
    case UserPassword(String, String, [String: AnyObject])
    
    var URLRequest: NSMutableURLRequest {
        var method: Alamofire.Method {
            switch self {
            case .Subscribe:
                return .POST
            case .Login:
                return .POST
            case .UserInfo:
                return .GET
            case .UserProfile:
                return .PUT
            case .UserPassword:
                return .PUT
            }
        }
        
        let params: ([String: AnyObject]?) = {
            switch self {
            case .Subscribe(let userData):
                return userData
            case .Login(let authData):
                return authData
            case .UserInfo:
                return (nil)
            case .UserProfile(_, _, let userData):
                return userData
            case .UserPassword(_, _, let userData):
                return userData
            }
        }()
        
        let headers: (String) = {
            switch self {
            case .UserInfo(_, let token):
                return token
            case .Subscribe:
                return ""
            case .Login:
                return ""
            case .UserProfile(_, let token, _):
                return token
            case .UserPassword(_, let token, _):
                return token
            }
        }()
        
        let url:NSURL = {
            // build up and return the URL for each endpoint
            let relativePath:String?
            switch self {
            case .Login:
                relativePath = "/user/login"
            case .Subscribe:
                relativePath = "/user"
            case .UserInfo(let UserID, _):
                relativePath = "/user/\(UserID)"
            case .UserProfile(let UserID, _, _):
                relativePath = "/user/\(UserID)/profile"
            case .UserPassword(let UserID, _, _):
                relativePath = "/user/\(UserID)/password"
            }
    
            var URL = NSURL(string: UserRouter.baseURLString)!
            if let relativePath = relativePath {
                URL = URL.URLByAppendingPathComponent(relativePath)!
            }
            return URL
        }()
        
        let URLRequest = NSMutableURLRequest(URL: url)
        
        let encoding = Alamofire.ParameterEncoding.JSON
        URLRequest.setValue(headers, forHTTPHeaderField: "x-access-token")
        let (encodedRequest, _) = encoding.encode(URLRequest, parameters: params)
        
        encodedRequest.HTTPMethod = method.rawValue
        
        return encodedRequest
    }
}
