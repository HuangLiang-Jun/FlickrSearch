//
//  SearchView.swift
//  FlickrSearch
//
//  Created by 黃亮鈞 on 2019/3/6.
//  Copyright © 2019 黃亮鈞. All rights reserved.
//

import Foundation
import SnapKit

protocol SearchViewDelegate {
    func searchBtnPressed(text: String, perPage: String)
}
class SearchView: UIView, UITextFieldDelegate {
    
    lazy var delegate: SearchViewDelegate? = nil
    var keywordTextField: UITextField!
    var perPageTextField: UITextField!
    var searchButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: .zero)
        self.setupUI()
    }
    
    func cleanTextField() {
        keywordTextField.text = ""
        perPageTextField.text = ""
        searchButton.backgroundColor = .lightGray
        searchButton.isEnabled = false
    }
    
    // MARK - textField delegate
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == perPageTextField {
            let allowNums = CharacterSet(charactersIn: "0123456789")
            let inputNum = CharacterSet(charactersIn: string)
            return allowNums.isSuperset(of: inputNum)
        }
        
        return true
    }
    
    
    
    
    // MARK - setup UI
    private func setupUI() {
        
        keywordTextField = UITextField()
        keywordTextField.delegate = self
        keywordTextField.placeholder = "欲搜尋內容"
        keywordTextField.borderStyle = .roundedRect
        keywordTextField.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
        self.addSubview(keywordTextField)
        keywordTextField.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
        perPageTextField = UITextField()
        perPageTextField.delegate = self
        perPageTextField.placeholder = "每頁呈現數量"
        perPageTextField.borderStyle = .roundedRect
        perPageTextField.keyboardType = .phonePad
        perPageTextField.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
        self.addSubview(perPageTextField)
        perPageTextField.snp.makeConstraints { (make) in
            make.top.equalTo(keywordTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
        searchButton = UIButton()
        searchButton.setTitle("搜尋", for: .normal)
        searchButton.titleLabel?.textColor = .white
        searchButton.backgroundColor = .lightGray
        searchButton.isEnabled = false
        searchButton.addTarget(self, action: #selector(searchBtnPressed), for: .touchUpInside)
        self.addSubview(searchButton)
        searchButton.snp.makeConstraints { (make) in
            make.top.equalTo(perPageTextField.snp.bottom).offset(20)
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
    }
    
    
    @objc private func searchBtnPressed() {
        self.endEditing(true)
        delegate?.searchBtnPressed(text: self.keywordTextField.text!,
                                   perPage: perPageTextField.text!)
    }
    
    @objc private func textDidChange(textField: UITextField) {
        let tfNotEmpty = !keywordTextField.text!.isEmpty && !perPageTextField.text!.isEmpty
        searchButton.isEnabled = tfNotEmpty
        searchButton.backgroundColor = tfNotEmpty ? UIColor.blue : UIColor.lightGray
    }
    
}
