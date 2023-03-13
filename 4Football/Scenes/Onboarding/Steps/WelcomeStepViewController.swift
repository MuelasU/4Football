//
//  WelcomeStepViewController.swift
//  4Football
//
//  Created by Gabriel Muelas on 16/06/22.
//

import UIKit

class WelcomeStepViewController: UIViewController, OnboardingStep {
    var type: StepType { .welcome }

    var headingText: String { "Welcome" }

    var paragraphText: String { "teste teste teste teste teste teste teste teste teste teste teste" }

    override func loadView() {
        view = stepView
    }
}
