//
//  StepViewController.swift
//  4Football
//
//  Created by Gabriel Muelas on 13/07/22.
//

import UIKit

enum StepType: Int {
    case welcome, support, notifications
}

protocol OnboardingStep: UIViewController {
    var type: StepType { get }
    var headingText: String { get }
    var paragraphText: String { get }
    var child: UIView { get }
}

extension OnboardingStep {
    var child: UIView { .init() }

    var stepView: UIView {
        let head = UILabel()
        head.text = headingText
        head.font = .preferredFont(forTextStyle: .largeTitle, weight: .bold)
        head.setContentHuggingPriority(.required, for: .vertical)

        let paragraph = UILabel()
        paragraph.text = paragraphText
        paragraph.font = .preferredFont(forTextStyle: .body)
        paragraph.numberOfLines = 0
        paragraph.setContentHuggingPriority(.defaultHigh, for: .vertical)

        let stack = UIStackView(arrangedSubviews: [head, paragraph, child])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 32
        stack.alignment = .fill

        return stack
    }
}
