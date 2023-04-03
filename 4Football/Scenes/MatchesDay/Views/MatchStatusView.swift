import UIKit

class MatchStatusView: UIStackView {
    var matchInfo: MatchInfo? {
        didSet {
            guard let matchInfo = matchInfo else {
                return
            }

            switch matchInfo.status {
            case .notStarted:
                label.font = .preferredFont(forTextStyle: .headline)
                label.textColor = .label
                label.text = matchInfo.date.timeOfTheDay
            case .finished:
                label.font = .preferredFont(forTextStyle: .subheadline)
                label.textColor = .secondaryLabel
                label.text = "Fim"
            case .firstHalf, .secondHalf, .extraTime:
                label.font = .preferredFont(forTextStyle: .subheadline)
                label.textColor = .oceanic
                label.text = String(matchInfo.time!)
            default:
                break
            }
        }
    }
    
    private lazy var label: UILabel = UILabel()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        axis = .vertical
        spacing = 4
        distribution = .fill
        alignment = .center
        addArrangedSubview(label)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

