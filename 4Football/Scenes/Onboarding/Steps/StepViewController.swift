//
//  StepViewController.swift
//  4Football
//
//  Created by Gabriel Muelas on 13/07/22.
//

import UIKit

class StepViewController: UIViewController {
    var headingText: String { "" }
    var paragraphText: String { "" }
    var child: UIView { .init() }
    
    private lazy var head: UILabel = {
        let label = UILabel()
        label.text = headingText
        label.font = .preferredFont(forTextStyle: .largeTitle, weight: .bold)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var paragraph: UILabel = {
        let label = UILabel()
        label.text = paragraphText
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [head, paragraph, child])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 32
        stack.alignment = .fill
        return stack
    }()
    
    override func loadView() {
        view = stackView
    }
}
