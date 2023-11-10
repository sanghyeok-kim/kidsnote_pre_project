//
//  BaseViewController.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        layoutUI()
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: Literal.Text.back.appString,
            style: .plain,
            target: nil,
            action: nil
        )
    }
    
    func layoutUI() { }
    
    deinit {
        Logger.logDeallocation(object: self)
    }
}
