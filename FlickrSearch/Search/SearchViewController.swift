//
//  SearchViewController.swift
//  FlickrSearch
//
//  Created by 黃亮鈞 on 2019/3/6.
//  Copyright © 2019 黃亮鈞. All rights reserved.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController, SearchViewDelegate {

    
    var searchView: SearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "搜尋輸入頁"
        setupUI()
    }
    
    func searchPhotos(text: String, perPage: String) {
        showProgress()
        ServerCommunicator.shared.search(text: text, perPage: perPage, page: "1") {[weak self] (obj, errMsg) in
            stopProgress()
            if errMsg != nil {
                print(errMsg!)
                self?.showAlert(title: "Ooops!", msg: errMsg!)
                return
            }
            
            DispatchQueue.main.async {
                self?.searchView.cleanTextField()
                self?.pushToResultVC(obj: obj!)
            }
        }
    }
    
    func pushToResultVC(obj: FlickrObject) {
        let vc = SearchResultViewController()
        vc.flickrObj = obj
        
        self.show(vc, sender: nil)
        
    }
    
    
    // MARK - setup UI
    func setupUI() {
        
        searchView = SearchView()
        searchView.delegate = self
        view.addSubview(searchView)
        searchView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }

    }
    
    func searchBtnPressed(text: String, perPage: String) {
        searchPhotos(text: text, perPage: perPage)
    }


}
