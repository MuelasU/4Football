//
//  OnboardingButtonsViewController.swift
//  4Football
//
//  Created by Gabriel Muelas on 10/06/22.
//

import UIKit

protocol OnboardingButtonsViewControllerDelegate: UIViewController {
    func didPushNext()
    func didPushPrevious()
}

class OnboardingButtonsViewController: UIViewController {

    weak var delegate: OnboardingButtonsViewControllerDelegate?
    
    private lazy var buttons: [Button] = {
        let buttonContinue = Button(title: "Continue")
        buttonContinue.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        let buttonPrevious = Button(title: "Previous")
        buttonPrevious.addTarget(self, action: #selector(previousPage), for: .touchUpInside)
        return [buttonPrevious, buttonContinue]
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func loadView() {
        view = stackView
    }

    @objc func nextPage() {
        delegate?.didPushNext()
    }
    
    @objc func previousPage() {
        delegate?.didPushPrevious()
    }
}
