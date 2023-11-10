//
//  String+convertToDateFormatted.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/10.
//

import Foundation

extension String {
    func convertToDateFormatted() -> String {
        if self.count == 4 {
            return "\(self)년"
        }
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy년 M월 d일"
            return outputFormatter.string(from: date)
        }
        return self
    }
}
