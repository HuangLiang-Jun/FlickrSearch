//
//  SearchResultViewController.swift
//  FlickrSearch
//
//  Created by 黃亮鈞 on 2019/3/6.
//  Copyright © 2019 黃亮鈞. All rights reserved.
//

import UIKit
import SnapKit

class SearchResultViewController: UIViewController, PhotoCollectionViewDelegate {

    var flickrObj: FlickrObject? = nil
    var phototCollectionView: PhotoCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "搜尋結果 \(flickrObj?.searchText ?? "")"
        setupUI()
    }
    
    // setup UI
    func setupUI() {
        
        phototCollectionView = PhotoCollectionView(obj: self.flickrObj)
        phototCollectionView.delegate = self
        view.addSubview(phototCollectionView)
        phototCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func loadPhotFail(with errorMsg: String) {
        self.showAlert(title: "Oooops!", msg: errorMsg)
    }
}
