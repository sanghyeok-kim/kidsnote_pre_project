//
//  BookDetailViewController.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/09.
//

import UIKit

import ReactorKit
import RxCocoa
import RxSwift

final class BookDetailViewController: BaseViewController, View {
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Bind Reactor
    
    func bind(reactor: BookDetailReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    // MARK: - Configure UI
    
    override func configureUI() {
        super.configureUI()
        
    }
    
    // MARK: - Layout UI
    
    override func layoutUI() {
        super.layoutUI()
        
    }
}

// MARK: - Bind Reactor

private extension BookDetailViewController {
    func bindAction(reactor: BookDetailReactor) {
        
    }
    
    func bindState(reactor: BookDetailReactor) {
        
    }
}

