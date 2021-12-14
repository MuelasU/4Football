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
}

extension ViewCodable {
    func configureViews() {}
    
    func setupViews() {
        buildHierarchy()
        setupConstraints()
        configureViews()
    }
}
