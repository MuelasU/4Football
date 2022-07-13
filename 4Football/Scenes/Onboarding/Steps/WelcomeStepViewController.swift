//
//  WelcomeStepViewController.swift
//  4Football
//
//  Created by Gabriel Muelas on 16/06/22.
//

import UIKit

class WelcomeStepViewController: UIViewController {

    private lazy var head: UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private lazy var paragraph: UIStackView = {
        let label = UILabel()
        label.text = """
        Et sed arcu massa tristique cursus elit, placerat. Velit dui, eget tempor, interdum consectetur non. Adipiscing ut commodo eget vel lacus at pellentesque semper. Amet vitae.
        """
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        let stack = UIStackView(arrangedSubviews: [label])
        stack.axis = .horizontal
        stack.alignment = .top
        stack.setContentHuggingPriority(.defaultLow, for: .vertical)
        return stack
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [head, paragraph])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 32
        stack.alignment = .leading
        return stack
    }()
    
    override func loadView() {
        view = stackView
    }

}
