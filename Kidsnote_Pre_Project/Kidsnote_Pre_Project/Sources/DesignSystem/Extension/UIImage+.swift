//
//  UIImage+.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/06.
//

import UIKit

extension UIImage {
    func resizeAspectFit(width: CGFloat) -> UIImage? {
        defer { UIGraphicsEndImageContext() }
        
        let aspectSize = CGSize(width: width, height: ceil(width / size.width * size.height))
        
        UIGraphicsBeginImageContextWithOptions(aspectSize, false, UIScreen.main.scale)
        draw(in: CGRect(origin: .zero, size: aspectSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        return resizedImage
    }
}
