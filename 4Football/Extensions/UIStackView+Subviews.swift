//
//  UIScrollView+Subviews.swift
//  4Football
//
//  Created by Gabriel Muelas on 15/12/21.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) -> UIStackView {
        for view in views {
            self.addArrangedSubview(view)
        }
        return self
    }
}
