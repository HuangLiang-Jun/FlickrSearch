//
//  PhotoCollectionView.swift
//  FlickrSearch
//
//  Created by 黃亮鈞 on 2019/3/7.
//  Copyright © 2019 黃亮鈞. All rights reserved.
//

import UIKit
import SnapKit
protocol PhotoCollectionViewDelegate {
    func loadPhotFail(with errorMsg: String)
}

class PhotoCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, PhotoCollectionViewCellDelegate {
    
    private let cellIdentifier = "Cell"
    private var collectioView: UICollectionView!
    private var object: FlickrObject? = nil
    private var noDataTitle: String = "Ooops!沒有照片!"
    var delegate: PhotoCollectionViewDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(obj: FlickrObject?, noDataTitle: String? = "Ooops!沒有照片!") {
        self.init(frame: .zero)
        self.noDataTitle = noDataTitle!
        self.object = obj
        setupUI()
    }
    
    func reloadData(photos: [Photo]) {
        self.object?.photos = photos
        collectioView.reloadData()
    }
    
    private func setupUI() {
        let columnLayout = ColumnFlowLayout(
            cellsPerRow: 2,
            minimumInteritemSpacing: 10,
            minimumLineSpacing: 10,
            sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        )
        
        collectioView = UICollectionView(frame: .zero, collectionViewLayout: columnLayout)
        collectioView.delegate = self
        collectioView.dataSource = self
        collectioView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        let bgLabel = UILabel()
        bgLabel.text = noDataTitle
        bgLabel.textAlignment = .center
        collectioView.backgroundView = bgLabel
        collectioView.backgroundColor = .white
        
        addSubview(collectioView)
        collectioView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: UICollectionDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = object?.photos.count ?? 0
        collectionView.backgroundView?.isHidden = count != 0
        return object?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotoCollectionViewCell
        
        
        let photo = object?.photos[indexPath.item]
        cell.setup(photo: photo!)
     
        if self.viewContainingController()!.isKind(of: FavoriteViewController.self) {
            cell.delegate = self
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if object == nil { return }
        if indexPath.item == object!.photos.count - 1 && object!.currentPage < object!.lastPages {
            
            ServerCommunicator.shared.search(flickrObj: object!, text: object!.searchText, perPage: "\(object!.perpage)", page: "\(object!.currentPage + 1)") { [weak self] (obj, errMsg) in
                if errMsg != nil {
                    self?.delegate?.loadPhotFail(with: errMsg!)
                    return
                }
                
                
                self?.object = obj
                DispatchQueue.main.async {
                    self?.collectioView.reloadData()
                }
            }
        }
    }
    
    //MARK: cell delegate
    
    func unLikePhoto(indexPath: IndexPath?) {
        if let indexpath = indexPath {
            self.object?.photos.remove(at: indexpath.item)
            DispatchQueue.main.async {[weak self] in
                self?.collectioView.reloadData()
            }
        }
    }
}
