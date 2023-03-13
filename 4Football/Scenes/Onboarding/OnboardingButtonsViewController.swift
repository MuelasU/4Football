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

    let previousButton: Button
    let continueButton: Button

    init() {
        previousButton = Button(title: "Previous", type: .back)
        continueButton = Button(title: "Continue", type: .next)
        super.init(nibName: nil, bundle: nil)

        previousButton.addTarget(self, action: #selector(previousPage), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [previousButton, continueButton])
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
