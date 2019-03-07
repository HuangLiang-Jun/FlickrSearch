//
//  RLM_Photo.swift
//  FlickrSearch
//
//  Created by 黃亮鈞 on 2019/3/7.
//  Copyright © 2019 黃亮鈞. All rights reserved.
//

import Foundation
import RealmSwift

class RLM_Photo: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var imageUrl: String = ""
 
    override static func primaryKey() -> String? {
        return "id"
    }
}
