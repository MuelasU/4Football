//
//  PageControllerViewController.swift
//  4Football
//
//  Created by Gabriel Muelas on 09/03/22.
//

import UIKit

class MatchesPageViewController: UIPageViewController {
    
    private let updateHandler: (Date, AnyObject) -> Void
    
    // MARK: - Init
    init(firstDay: Date, update handler: @escaping (Date, AnyObject) -> Void) {
        self.updateHandler = handler
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        let initialViewController = createMatchesDayViewController(for: firstDay)
        setViewControllers([initialViewController], direction: .forward, animated: true, completion: nil)
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func updateView(with newDay: Date) {
        let newViewController = createMatchesDayViewController(for: newDay)
        setViewControllers([newViewController], direction: .forward, animated: true)
    }
    
    private func createMatchesDayViewController(for date: Date) -> MatchesDayViewController {
        return MatchesDayViewController(day: date)
    }
}

extension MatchesPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // load previous page
        let date = (viewController as! MatchesDayViewController).day
        let dayBefore = date.dayBefore
        return createMatchesDayViewController(for: dayBefore)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // load next page
        let date = (viewController as! MatchesDayViewController).day
        let dayAfter = date.dayAfter
        return createMatchesDayViewController(for: dayAfter)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        // sync indexes
        if finished {
            guard let displayedViewController = viewControllers?.first as? MatchesDayViewController else {
                return
            }
            
            updateHandler(displayedViewController.day, self)
        }
    }
}
