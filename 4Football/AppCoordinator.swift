import UIKit

class AppCoordinator {
    private let navigationController = {
        let nav = UINavigationController()
        nav.isNavigationBarHidden = true
        return nav
    }()

    private lazy var onboarding: OnboardingContainerViewController = {
        let vc = OnboardingContainerViewController()
        vc.didFinishOnboarding = {
            self.navigationController.pushViewController(self.matches, animated: true)
        }
        return vc
    }()
    private lazy var matches = MatchesContainerViewController()

    func start() {
        navigationController.isNavigationBarHidden = true
        if UserSession.shared.isUserDefined {
            navigationController.pushViewController(matches, animated: false)
        } else {
            navigationController.pushViewController(onboarding, animated: false)
        }
    }

    var rootViewController: UINavigationController {
        navigationController
    }
}
