//
//  PageControllerViewController.swift
//  4Football
//
//  Created by Gabriel Muelas on 09/03/22.
//

import UIKit

class MatchesPageViewController: UIPageViewController {
    
    private var displayedDay: Date = .now
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        let initialViewController = createMatchesDayViewController(for: displayedDay)
        setViewControllers([initialViewController], direction: .forward, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        dataSource = self
    }
    
    func createMatchesDayViewController(for date: Date) -> MatchesDayViewController {
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
            
            displayedDay = displayedViewController.day
        }
    }
}
