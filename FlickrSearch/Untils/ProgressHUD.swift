//
//  ProgressHUD.swift
//  FlickrSearch
//
//  Created by 黃亮鈞 on 2019/3/7.
//  Copyright © 2019 黃亮鈞. All rights reserved.
//

import Foundation
import SVProgressHUD

public func showProgress() {
    SVProgressHUD.setDefaultMaskType(.black)
    SVProgressHUD.setMinimumSize(CGSize(width: 50, height: 50))
    SVProgressHUD.show()
}


public func stopProgress() {
    SVProgressHUD.dismiss()
}
