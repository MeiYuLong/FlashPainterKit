//
//  FPPaintManager.swift
//  FlashPainterKit
//
//  Created by yulong mei on 2021/9/24.
//

import Foundation

public class FPPaintManager {
    
    /// 绘制365小标签
    /// - Parameters:
    ///   - type: 尺寸类型
    ///   - data: 地址信息
    ///   - bottom: 底部边距
    /// - Returns: 图片
    public static func draw365Label(type: EPPrinterType = .P2, data: FPLabelBaseData, _ bottom: CGFloat = 10) -> UIImage {
        return EPPaint.shared.draw365Label(type: type, data: data, bottom: bottom)
    }
    
    /// 绘制快递小标签
    /// - Parameters:
    ///   - data: 订单数据
    ///   - bottom: 底部边距
    /// - Returns: 图片
    public static func drawPNOLabel(data: FPTicketLabelData, _ bottom: CGFloat = 10) -> UIImage {
        return FPPaint.shared.drawPNOLabel(data: data, bottom)
    }
    
    public static func checkImageSize(image: UIImage, type: EPPrinterType = .P2) -> UIImage {
        let imageSize = image.size
        let targetWidth = CGFloat(type.rawValue)
        if imageSize.width < targetWidth {
            let newImage = self.scaleToOriginSize(image: image, width: targetWidth) ?? image
            return newImage
        }
        return image
    }
    
    /// image size真是尺寸 = size * scale
    private static func scaleToOriginSize(image: UIImage, width: CGFloat) -> UIImage? {
        let orginSize = image.size
        // 宽高要为整数，如果不为整数，可能出现一个没有色值的边线，抖动算法和二值化时，没有色值等于黑色
        let newSize = CGSize(width: width, height: ceil(orginSize.height / orginSize.width * width))

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImg
    }
}
