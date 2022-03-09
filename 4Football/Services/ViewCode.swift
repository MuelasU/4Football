//
//  ViewCode.swift
//  4Football
//
//  Created by Gabriel Muelas on 13/12/21.
//

import UIKit

protocol ViewCodable: UIView {
    func buildHierarchy()
    func setupConstraints()
    func configureViews()
    func applyAccessibility()
}

extension ViewCodable {
    func configureViews() {}
    
    func applyAccessibility() {}
    
    func setupViews() {
        buildHierarchy()
        setupConstraints()
        configureViews()
        applyAccessibility()
    }
}
