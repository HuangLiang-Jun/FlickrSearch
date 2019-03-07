//
//  FlickrParserManager.swift
//  FlickrSearch
//
//  Created by 黃亮鈞 on 2019/3/6.
//  Copyright © 2019 黃亮鈞. All rights reserved.
//

import Foundation
import SwiftyJSON
class FlickrParsrManager {
    
    
    static func photosParser(flickrObj: FlickrObject? = nil, data: Data) -> (obj: FlickrObject?, err: String?) {
        
        if let json = try? JSON(data: data) {
            
            if let stat = json.dictionary?["stat"]?.string, stat != "ok" {
                let errorMessage = json.dictionary?["message"]?.string
                return (nil, errorMessage!)
            }
            
            guard let photos = json.dictionary?["photos"] else { return (nil,"convert to json failed.")}
            
            let obj = flickrObj ?? FlickrObject()
            
            let currentPage = photos["page"].int ?? 1
            let lastPage = photos["pages"].int ?? 1
            let perpage = photos["perpage"].int ?? 20
            let photoArray = photos["photo"].array ?? []
            
            for i in photoArray {
                let id = i["id"].string ?? ""
                let title = i["title"].string ?? "unKnow"
                let farm = i["farm"].int ?? 0
                let server = i["server"].string ?? ""
                let secret = i["secret"].string ?? ""
                
                let imageURL = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg"
                let isLike = RLM_Manager.share.isLike(id: id)
                let p = Photo(id: id, title: title, imageURL: imageURL, isLike: isLike)
                obj.photos.append(p)
            }
            
            obj.currentPage = currentPage
            obj.lastPages = lastPage
            obj.perpage = perpage
            return (obj, nil)
        }
        
        return (nil, "data isn't json format.")
    }
    
}
