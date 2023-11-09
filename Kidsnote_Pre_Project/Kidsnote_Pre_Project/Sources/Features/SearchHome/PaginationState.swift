//
//  PaginationState.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/08.
//

import Foundation

struct PaginationState {
    let maxResultCount: Int
    var currentIndex: Int
    var startIndex: Int
    var totalLoadedItemsCount: Int = 0
    var isLoading: Bool = false
    
    var canLoadMore: Bool {
        return !isLoading && (maxResultCount <= totalLoadedItemsCount)
    }
    
    init(maxResultCount: Int = 20, startIndex: Int = 0) {
        self.maxResultCount = maxResultCount
        self.currentIndex = startIndex
        self.startIndex = startIndex
    }
    
    func finishLoading(appendedItemCount: Int = 0) -> PaginationState {
        var newState = self
        newState.isLoading = false
        newState.totalLoadedItemsCount += appendedItemCount
        return newState
    }
    
    func prepareNextPage() -> PaginationState {
        var newState = self
        newState.isLoading = true
        newState.currentIndex += maxResultCount
        return newState
    }
    
    func resetToInitial() -> PaginationState {
        var newState = self
        newState.currentIndex = startIndex
        newState.totalLoadedItemsCount = 0
        newState.isLoading = false
        return newState
    }
}
