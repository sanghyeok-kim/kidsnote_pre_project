//
//  UIImage+.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/06.
//

import UIKit

extension UIImage {
    func resizedAspect(width newWidth: CGFloat) -> UIImage? {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        
        let newSize = CGSize(width: newWidth, height: newHeight)
        return resizeAspectFit(to: newSize)
    }
    
    private func resizeAspectFit(to newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let resizedImage = renderer.image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
        return resizedImage
    }
}
