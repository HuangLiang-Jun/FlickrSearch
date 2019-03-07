//
//  PhotoCollectionViewCell.swift
//  FlickrSearch
//
//  Created by 黃亮鈞 on 2019/3/7.
//  Copyright © 2019 黃亮鈞. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
protocol PhotoCollectionViewCellDelegate {
    func unLikePhoto(indexPath: IndexPath?)
}

class PhotoCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var titleLabel: UILabel!
    var likeButton: UIButton!
    var delegate: PhotoCollectionViewCellDelegate? = nil
    
    private var photo: Photo!
    
    func setup(photo: Photo) {
        self.photo = photo
        if imageView == nil {
            imageView = UIImageView()
            self.addSubview(imageView)
            imageView.snp.makeConstraints { (make) in
                make.top.left.right.equalToSuperview()
                make.width.height.equalTo(contentView.snp.width)
            }
        }
        let url = URL(string: photo.imageURL)
        imageView.kf.setImage(with: url)
        
        if likeButton == nil {
            likeButton = UIButton()
            likeButton.setImage(UIImage(named: "like")!, for: .selected)
            likeButton.setImage(UIImage(named: "unlike")!, for: .normal)
            likeButton.addTarget(self, action: #selector(likeButtonPressed(sender:)), for: .touchUpInside)
            addSubview(likeButton)
            likeButton.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(5)
                make.top.equalTo(imageView.snp.bottom).offset(5)
                make.width.height.equalTo(30)
            }
        }
        likeButton.isSelected = photo.isLike
        
        if titleLabel == nil {
            titleLabel = UILabel()
            titleLabel.numberOfLines = 2
            addSubview(titleLabel)
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(likeButton)
                make.left.equalTo(likeButton.snp.right).offset(5)
                make.right.equalToSuperview()
            }
        }
        
        titleLabel.text = photo.title
    }
    
    
    @objc func likeButtonPressed(sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
           
            // store photo
            RLM_Manager.share.storePhoto(with: photo)
        } else {
            
            // remove photo
            RLM_Manager.share.removePhoto(with: photo.id)
            delegate?.unLikePhoto(indexPath: getIndexPath())
        }
    }
    
    func getIndexPath() -> IndexPath? {
        guard let superView = self.superview as? UICollectionView else {
            return nil
        }
        let indexPath = superView.indexPath(for: self)
        return indexPath
    }
}
