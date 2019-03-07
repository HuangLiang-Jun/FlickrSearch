//
//  RLM_Manager.swift
//  FlickrSearch
//
//  Created by 黃亮鈞 on 2019/3/7.
//  Copyright © 2019 黃亮鈞. All rights reserved.
//

import Foundation
import RealmSwift

class RLM_Manager {

    static let share = RLM_Manager()
    let realm = try! Realm()
    
    func storePhoto(with photo: Photo) {
        
        let p = RLM_Photo()
        p.id = photo.id
        p.title = photo.title
        p.imageUrl = photo.imageURL
        try! realm.write {
            realm.add(p)
        }
    }
    
    func removePhoto(with id: String) {
        guard let obj = realm.objects(RLM_Photo.self).filter("id = '\(id)'").first else { return }
        try! realm.write {
            realm.delete(obj)
        }
    }
    
    func fetchPhotos() -> [Photo] {
        let rlm_photos = realm.objects(RLM_Photo.self)
        let arr = rlm_photos.toArray(ofType: RLM_Photo.self) as [RLM_Photo]
        var photos: [Photo] = []
        for i in arr {
            let p = Photo.init(id: i.id, title: i.title, imageURL: i.imageUrl, isLike: true)
            photos.append(p)
        }
        
        return photos
    }
    
    func isLike(id: String) -> Bool {
        let isEmpty = realm.objects(RLM_Photo.self).filter("id = '\(id)'").isEmpty
        return !isEmpty
    }
    
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}
