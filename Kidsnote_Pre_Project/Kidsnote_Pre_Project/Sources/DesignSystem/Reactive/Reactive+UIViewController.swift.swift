//
//  Rx+viewDidLoad.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/04.
//

import RxCocoa
import RxSwift

public extension Reactive where Base: UIViewController {
    var viewDidLoad: Observable<Void> {
        let targetSelector = #selector(Base.viewDidLoad)
        return sentMessage(targetSelector).map { _ in }
    }
}
