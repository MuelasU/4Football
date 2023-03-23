import UIKit

class MatchesDayView: UIView {
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var loadingIndicator: UIStackView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.startAnimating()
        let stack = UIStackView(arrangedSubviews: [view])
        stack.distribution = .fill
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var noMatchesView: UIStackView = {
        let label = UILabel()
        label.text = "No matches for today"
        label.textAlignment = .center
        let stack = UIStackView(arrangedSubviews: [label])
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    //MARK: - View building

    func setView(for state: MatchesDayViewController.State) {
        subviews.forEach { $0.removeFromSuperview() }
        NSLayoutConstraint.deactivate(constraints)
        let view: UIView = {
            switch state {
            case .loading:
                return loadingIndicator
            case .loaded:
                return tableView
            case .noMatches:
                return noMatchesView
            }
        }()
        addSubview(view)
        setupConstraints(for: view)
    }

    private func setupConstraints(for view: UIView) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}




