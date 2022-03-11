//
//  MatchesViewController.swift
//  4Football
//
//  Created by Gabriel Muelas on 13/12/21.
//

import UIKit

class MatchesContainerViewController: UIViewController, UIViewControllerContainer {
    
    var day: Date = .now
    
    private lazy var matchesPageViewController: MatchesPageViewController = MatchesPageViewController()
    private lazy var pageControlViewController: PageControlViewController = PageControlViewController()
    
    override func loadView() {
        let matchesPageViewController = addChildViewController(viewController: matchesPageViewController)
        let pageControlViewController = addChildViewController(viewController: pageControlViewController)
        view = MatchesContainerView(
            matchesPageView: matchesPageViewController.view,
            pageControlView: pageControlViewController.view
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Matches"
    }
}

protocol UIViewControllerContainer: UIViewController {}

extension UIViewControllerContainer {
    func addChildViewController(viewController child: UIViewController) -> UIViewController {
        addChild(child)
        child.didMove(toParent: self)
        return child
    }
}
