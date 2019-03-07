//
//  FlickrAPI.swift
//  FlickrSearch
//
//  Created by 黃亮鈞 on 2019/3/6.
//  Copyright © 2019 黃亮鈞. All rights reserved.
//

import Foundation
import Moya

enum FlickrAPI {
    case search(text: String, perPage: String, page: String)
    case nextPage(page: String)
}

extension FlickrAPI: TargetType {
    
    
    var baseURL: URL {
        return URL(string: "https://api.flickr.com/services/rest/")!
    }
    
    var path: String {
        
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters ?? [:], encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
      
        switch self {
            
        case .search(let text, let perPage, let page):
            let dic: [String: Any] = ["method": "flickr.photos.search",
                       "api_key": "0047c7f02d8ddde0c7f619cde2a34928",
                       "format": "json",
                       "nojsoncallback": 1, // 去掉 jsonFlickrApi
                       "text": text,
                       "per_page": perPage,
                       "page": page]
            
            return dic
        
        default:
        
            return nil
        
        }
    
    }


}
