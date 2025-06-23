//
//  ViewExtension.swift
//  PrivateNetwork
//
//  Created by Thomas on 2024/9/6.
//

import UIKit


extension UIViewController {
    
    /// 宽高适配 - 设计稿 （375 * 812），这里适配以宽为主去适配高
    /// 目标宽高适配（UIScreen.main.bounds.size.width * UIScreen.main.bounds.size.height）
    static func fitViewHeight(_ width: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.size.height * width / 812
    }

    func fitViewHeight(_ width: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.size.height * width / 812
    }
}

extension UIView {
    
    /// 宽高适配 - 设计稿 （375 * 812），这里适配以宽为主去适配高
    static func fitViewHeight(_ width: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.size.height * width / 812
    }

    func fitViewHeight(_ width: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.size.height * width / 812
    }
}

extension UIFont {
    
    enum MontserratFontType {
        case regular
        case medium
        case semiBold
        case bold
    }
    
    static func fitViewHeight(_ width: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.size.height * width / 812
    }
    
    static func fitFont(_ type: MontserratFontType = MontserratFontType.regular, _ size: CGFloat) -> UIFont {
        if type == .regular {
            return UIFont(name: "Montserrat-Regular", size: fitViewHeight(size))!
        } else if type == .medium {
            return UIFont(name: "Montserrat-Medium", size: fitViewHeight(size))!
        } else if type == .semiBold {
            return UIFont(name: "Montserrat-SemiBold", size: fitViewHeight(size))!
        } else {
            return UIFont(name: "Montserrat-Bold", size: fitViewHeight(size))!
        }
    }
    
}


extension UIView {
    // MARK: - Frame Properties

    var frameTop: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }

    var frameLeft: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }

    var frameRight: CGFloat {
        get {
            return frame.origin.x + frame.size.width
        }
        set {
            // 计算新的 origin.x 以使右侧位置与 newValue 对齐
            let width = frame.size.width
            let originX = newValue - width
            var frame = self.frame
            frame.origin.x = originX
            self.frame = frame
        }
    }

    var frameBottom: CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
        set {
            // 计算新的 origin.y 以使底部位置与 newValue 对齐
            let height = frame.size.height
            let originY = newValue - height
            var frame = self.frame
            frame.origin.y = originY
            self.frame = frame
        }
    }
    
    // MARK: - Size Properties

    var frameSize: CGSize {
        get {
            return frame.size
        }
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }

    var frameWidth: CGFloat {
        get {
            return frame.size.width
        }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }

    var frameHeight: CGFloat {
        get {
            return frame.size.height
        }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }

    // MARK: - Center Properties

    var frameCenterX: CGFloat {
        get {
            return center.x
        }
        set {
            center.x = newValue
        }
    }

    var frameCenterY: CGFloat {
        get {
            return center.y
        }
        set {
            center.y = newValue
        }
    }

    // MARK: - Convenience Initializer

    convenience init(frame: CGRect, backgroundColor: UIColor) {
        self.init(frame: frame)
        self.backgroundColor = backgroundColor
    }
}


extension UILabel {
    
    /// 计算给定宽度下 `UILabel` 的高度
    ///
    /// - Parameter width: `UILabel` 的宽度
    /// - Returns: 适应文本内容所需的高度
    ///
    @discardableResult
    func heightAuthSize(_ width: CGFloat) -> CGSize {
        // 确保 `text` 和 `font` 都已设置
        guard let text = self.text, let font = self.font else {
            return CGSize(width: 0, height: 0)
        }
        // 创建一个适合内容的高度计算
        let maxSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        // 使用 NSString 的 boundingRect 方法计算文本的高度
        let textRect = text.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [.font: font], context: nil)
        // 自动赋值
        self.frameSize = textRect.size
        // 返回计算得到的高度
        return textRect.size
    }
}
