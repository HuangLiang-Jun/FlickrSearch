//
//  Extension+UIViewController.swift
//  FlickrSearch
//
//  Created by 黃亮鈞 on 2019/3/7.
//  Copyright © 2019 黃亮鈞. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String? = "", msg: String? = "") {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
}
