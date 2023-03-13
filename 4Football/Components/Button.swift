//
//  Button.swift
//  4Football
//
//  Created by Gabriel Muelas on 10/06/22.
//

import UIKit

class Button: UIButton {
    enum ButtonType {
        case back, next
    }

    let type: ButtonType

    init(title: String, type: Button.ButtonType) {
        self.type = type
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        backgroundColor = .oceanic
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        let superSize = super.intrinsicContentSize
        return CGSize(
            width: superSize.width + 32,
            height: superSize.height + 8
        )
    }

    func disable() {
        isEnabled = false
        backgroundColor = .quaternaryLabel
    }

    func enable() {
        isEnabled = true
        backgroundColor = .oceanic
    }

    func hide() {
        layer.opacity = 0
        isEnabled = false
    }

    func show() {
        layer.opacity = 1
        isEnabled = true
    }
}
