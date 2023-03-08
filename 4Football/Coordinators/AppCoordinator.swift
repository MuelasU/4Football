import UIKit

class AppCoordinator {
    private let navigationController = UINavigationController()

    var rootViewController: UINavigationController {
        navigationController
    }

    func start() {
        let onboarding = OnboardingContainerViewController()
        navigationController.pushViewController(onboarding, animated: false)
    }
}
