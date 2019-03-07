//
//  Photo.swift
//  FlickrSearch
//
//  Created by 黃亮鈞 on 2019/3/6.
//  Copyright © 2019 黃亮鈞. All rights reserved.
//

import Foundation

class FlickrObject {
    var currentPage: Int = 1
    var lastPages: Int = 1
    var perpage: Int = 20
    var searchText: String = ""
    var photos: [Photo] = []
    
    
}



struct Photo {
    let id: String
    let title: String
    let imageURL: String
    var isLike: Bool
}
