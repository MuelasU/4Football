import UIKit
import Combine

class MatchesContainerViewController: UIViewController {
    
    // MARK: - Data
    private var displayedDay: Date
    private let userSession: UserSession
    
    private lazy var selectedDayChanged: (Date, AnyObject) -> Void =  { newDay, sender in
        self.displayedDay = newDay
        if type(of: sender) == MatchesPageViewController.self {
            self.dayPickerViewController.updateView(with: self.displayedDay)
        } else if type(of: sender) == DayPickerViewController.self {
            self.matchesPageViewController.updateView(with: self.displayedDay)
        }
    }
    
    // MARK: - Childs
    private lazy var matchesPageViewController: MatchesPageViewController = .init(
        firstDay: displayedDay,
        userSession: userSession,
        update: selectedDayChanged
    )
    
    private lazy var dayPickerViewController: DayPickerViewController = .init(
        firstDay: displayedDay,
        update: selectedDayChanged
    )
    
    // MARK: - View
    override func loadView() {
        let matchesPageViewController = addChildAndNotify(viewController: matchesPageViewController)
        let dayPickerViewController = addChildAndNotify(viewController: dayPickerViewController)
        view = MatchesContainerView(
            matchesPageView: matchesPageViewController.view,
            dayPickerView: dayPickerViewController.view
        )
        navigationItem.title = "Matches"
    }
    
    // MARK: - Init
    init(userSession: UserSession, firstDay displayedDay: Date = .now) {
        self.displayedDay = displayedDay
        self.userSession = userSession
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIViewController {
    func addChildAndNotify(viewController child: UIViewController) -> UIViewController {
        addChild(child)
        child.didMove(toParent: self)
        return child
    }
}
