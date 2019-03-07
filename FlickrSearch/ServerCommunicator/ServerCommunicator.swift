//
//  ServerCommunicator.swift
//  FlickrSearch
//
//  Created by 黃亮鈞 on 2019/3/6.
//  Copyright © 2019 黃亮鈞. All rights reserved.
//

import Foundation
import Alamofire
import Moya

class ServerCommunicator  {

    static let shared = ServerCommunicator()
    private let api = MoyaProvider<FlickrAPI>(manager: DefaultAlamofireManager.shareManager)

    typealias DoneHandle = (_ obj: FlickrObject?, _ errorMsg: String?) -> ()

    func search(flickrObj: FlickrObject? = nil, text: String, perPage: String, page: String, done: @escaping DoneHandle) {
       
        let req: FlickrAPI = .search(text: text, perPage: perPage, page: page)

        self.request(req: req) { (result) in
            if result.error != nil {
                done(nil, result.error!.localizedDescription)
                return
            }
            guard let data = result.value?.data else {
                done(nil, "data is nil.")
                return
            }
            
            let result = FlickrParsrManager.photosParser(flickrObj: flickrObj, data: data)
            if result.err != nil {
                done(nil, result.err!)
                return
            }
            result.obj!.searchText = text
            done(result.obj!, nil)
        }
    }

    private func request(req: FlickrAPI, done: @escaping Moya.Completion ) {
        
        api.request(req) { (res) in
            done(res)
        }
    }
}


// set time out
class DefaultAlamofireManager: Alamofire.SessionManager {
    
    static let shareManager: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        return DefaultAlamofireManager(configuration: configuration)
    }()
    
}


