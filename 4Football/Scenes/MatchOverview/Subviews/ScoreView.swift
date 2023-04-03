import UIKit

class ScoreView: UIStackView {
    private let match: Match

    init(match: Match) {
        self.match = match
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        _ = addArrangedSubviews([
            teamView(match.teams.home),
            statusView,
            teamView(match.teams.away),
        ])
        alignment = .center
        distribution = .equalSpacing
        backgroundColor = .systemGroupedBackground
        layer.cornerRadius = 15
        layer.masksToBounds = true
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 20,
            leading: 30,
            bottom: 20,
            trailing: 30
        )
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var statusView: UIStackView = {
        let title = match.fixture.status.hasScore ? scoreLabel : dateLabel
        let subtitle = defaultSubLabel
        let stack = UIStackView(arrangedSubviews: [title, subtitle])
        stack.axis = .vertical
        stack.spacing = 6
        stack.alignment = .center
        return stack
    }()

    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "\(String(match.goals.home ?? 0))x\(String(match.goals.away ?? 0))"
        label.font = .preferredFont(forTextStyle: .largeTitle, weight: .bold)
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        let date = match.fixture.date
        if date.isSameDay(to: .now) {
            label.text = date.timeOfTheDay
        } else if date.isSameDay(to: .now.dayAfter) {
            label.text = "Tomorrow"
        } else {
            label.text = "\(date.dayOfTheWeek), \(date.dayOfTheMonth)"
        }
        label.font = .preferredFont(forTextStyle: .headline, weight: .bold)
        return label
    }()

    private lazy var defaultSubLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1, weight: .regular)
        label.textColor = .secondaryLabel
        label.text = {
            switch match.fixture.status {
            case .finished: return "Ended game"
            case .notStarted: return match.fixture.date.timeOfTheDay
            case .halftime: return "Half-time"
            default: return ""
            }
        }()
        return label
    }()

    private lazy var inPlaySubLabel: UILabel = {
        let label = UILabel()

        // TODO: inPlaySubLabel

        return label
    }()

    private func teamView(_ team: Team) -> UIStackView {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.load(from: URL(string: team.imageUrl!), placeholder: .crest)
        let bounds = UIScreen.main.bounds
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: bounds.height/5),
            imageView.widthAnchor.constraint(equalToConstant: bounds.height/5)
        ])
        let label = UILabel()
        label.text = team.name
        label.font = .preferredFont(forTextStyle: .subheadline)
        let stack = UIStackView(arrangedSubviews: [imageView, label])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
}
