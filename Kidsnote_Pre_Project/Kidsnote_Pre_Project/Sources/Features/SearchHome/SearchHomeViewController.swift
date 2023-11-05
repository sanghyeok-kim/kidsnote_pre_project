//
//  SearchHomeViewController.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import UIKit

import ReactorKit
import RxCocoa
import RxSwift

final class SearchHomeViewController: BaseViewController, View {
    
    var reactor: SearchHomeReactor?
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Bind Reactor
    
    func bind(reactor: SearchHomeReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    // MARK: - Configure UI
    
    override func configureUI() {
        super.configureUI()
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Layout UI
    
    override func layoutUI() {
        super.layoutUI()
        
    }
}

// MARK: - Bind Reactor

private extension SearchHomeViewController {
    func bindAction(reactor: SearchHomeReactor) {
        
    }
    
    func bindState(reactor: SearchHomeReactor) {
        
    }
}
