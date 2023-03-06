//
//  OnboardingPageViewController.swift
//  4Football
//
//  Created by Gabriel Muelas on 10/06/22.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {

    private var currentIndex: Int = 0
    
    private lazy var steps: [StepViewController] = [
        WelcomeStepViewController(),
        SupportStepViewController(),
        NotificationStepViewController()
        // Insert new steps
    ]
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        setViewControllers([steps[currentIndex]], direction: .forward, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func nextStep() -> Int {
        guard steps.count > currentIndex + 1 else { return -1 }
        setViewControllers([steps[currentIndex + 1]], direction: .forward, animated: false)
        currentIndex = currentIndex + 1
        return currentIndex
    }
    
    func previousStep() -> Int {
        guard 0 <= currentIndex - 1 else { return -1 }
        setViewControllers([steps[currentIndex - 1]], direction: .reverse, animated: false)
        currentIndex = currentIndex - 1
        return currentIndex
    }
}
