//
//  OnboardingContainerViewController.swift
//  4Football
//
//  Created by Gabriel Muelas on 10/06/22.
//

import UIKit

class OnboardingContainerViewController: UIViewController {
    static private let numSteps = 3

    // MARK: - Childs
    private lazy var onboardingPageViewController: OnboardingPageViewController = .init()
    private lazy var walkthroughProgressView: WalkthroughProgressView = .init(total: Self.numSteps)
    private lazy var onboardingButtonsViewController: OnboardingButtonsViewController = .init()
    
    // MARK: - Setup View
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(walkthroughProgressView)
        view.addSubview(addChildAndNotify(viewController: onboardingPageViewController).view)
        view.addSubview(addChildAndNotify(viewController: onboardingButtonsViewController).view)
        
        walkthroughProgressView.translatesAutoresizingMaskIntoConstraints = false
        onboardingPageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        onboardingButtonsViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
        view.backgroundColor = .systemBackground
        
        onboardingButtonsViewController.delegate = self
    }
    
    private func setupConstraints() {
        view.layoutMargins = .init(top: 100, left: 60, bottom: 20, right: 60)
        
        NSLayoutConstraint.activate([
            walkthroughProgressView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            walkthroughProgressView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            walkthroughProgressView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            onboardingPageViewController.view.topAnchor.constraint(equalTo: walkthroughProgressView.bottomAnchor, constant: 100),
            onboardingPageViewController.view.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            onboardingPageViewController.view.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            onboardingPageViewController.view.bottomAnchor.constraint(equalTo: onboardingButtonsViewController.view.topAnchor),
            
            onboardingButtonsViewController.view.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            onboardingButtonsViewController.view.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            onboardingButtonsViewController.view.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
}

extension OnboardingContainerViewController: OnboardingButtonsViewControllerDelegate {
    
    //Update in PageViewController and in indicator view
    
    func didPushNext() {
        let stepIndex = onboardingPageViewController.nextStep()
        walkthroughProgressView.update(with: stepIndex)
    }
    
    func didPushPrevious() {
        let stepIndex = onboardingPageViewController.previousStep()
        walkthroughProgressView.update(with: stepIndex)
    }
}
