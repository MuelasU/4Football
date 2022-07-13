//
//  Button.swift
//  4Football
//
//  Created by Gabriel Muelas on 10/06/22.
//

import UIKit

class Button: UIButton {

    init(title: String) {
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

}
