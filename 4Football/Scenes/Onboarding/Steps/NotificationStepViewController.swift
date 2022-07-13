//
//  NotificationStepViewController.swift
//  4Football
//
//  Created by Gabriel Muelas on 13/07/22.
//

import UIKit

class NotificationStepViewController: UIViewController {

    private lazy var head: UILabel = {
        let label = UILabel()
        label.text = "Notifications"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private lazy var paragraph: UIStackView = {
        let label = UILabel()
        label.text = """
        Et sed arcu massa tristique cursus elit, placerat. Velit dui, eget tempor.
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
