import UIKit

class AppCoordinator {
    private var userSession: UserSession? = .init()

    private let navigationController = {
        let nav = UINavigationController()
        nav.isNavigationBarHidden = true
        return nav
    }()

    private lazy var onboarding: OnboardingContainerViewController = {
        let vc = OnboardingContainerViewController()
        vc.didFinishOnboarding = { userSession in
            self.userSession = userSession
            self.navigationController.pushViewController(self.matches, animated: true)
        }
        return vc
    }()
    
    private lazy var matches = MatchesContainerViewController(userSession: userSession!)

    func start() {
        navigationController.isNavigationBarHidden = true
        if userSession != nil {
            navigationController.pushViewController(matches, animated: false)
        } else {
            navigationController.pushViewController(onboarding, animated: false)
        }
    }

    var rootViewController: UINavigationController {
        navigationController
    }
}
