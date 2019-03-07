//
//  FavoriteViewController.swift
//  FlickrSearch
//
//  Created by 黃亮鈞 on 2019/3/6.
//  Copyright © 2019 黃亮鈞. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var collectionView: PhotoCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshObj()
        
    }
    
    func setupUI() {
        self.navigationItem.title = "我的最愛"
        
        let obj = FlickrObject()
        obj.photos = fetchObj()
        
        collectionView = PhotoCollectionView(obj: obj, noDataTitle: "你還沒有喜歡的照片!")
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    
    }
    
    func fetchObj() -> [Photo] {
        return RLM_Manager.share.fetchPhotos()
    }
   
    func refreshObj() {
        collectionView.reloadData(photos: fetchObj())
    }
}
