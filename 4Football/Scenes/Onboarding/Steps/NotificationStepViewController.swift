//
//  NotificationStepViewController.swift
//  4Football
//
//  Created by Gabriel Muelas on 13/07/22.
//

import UIKit

class NotificationStepViewController: UIViewController, OnboardingStep {
    var type: StepType { .notifications }

    var headingText: String { "Notifications" }

    var paragraphText: String { "teste teste teste teste teste teste teste teste teste teste teste teste teste teste teste teste teste teste" }

    override func loadView() {
        view = stepView
    }
}
