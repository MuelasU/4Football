import UIKit

class DayPickerCollectionViewCell: UICollectionViewCell {
    
    var day: Date! {
        didSet {
            dayOfTheWeekLabel.text = day.dayOfTheWeek.lowercased()
            dayOfTheMonthLabel.text = day.dayOfTheMonth
            dayOfTheMonthLabel.textColor = day.isSameDay(to: .now) ? .oceanic : .label   //Check if is today
        }
    }
    
    static let identifier = "DayCollectionViewCell"
    
    override var isSelected: Bool {
        didSet {
            selectorIndicator.isHidden = !isSelected
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews
    private lazy var dayOfTheWeekLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dayOfTheMonthLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var selectorIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .oceanic
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 1.5
        view.layer.masksToBounds = true
        view.isHidden = true
        return view
    }()
}

// MARK: - ViewCodable
extension DayPickerCollectionViewCell: ViewCodable {
    func buildHierarchy() {
        addSubview(dayOfTheWeekLabel)
        addSubview(dayOfTheMonthLabel)
        addSubview(selectorIndicator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            dayOfTheWeekLabel.topAnchor.constraint(equalTo: topAnchor),
            dayOfTheWeekLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            dayOfTheMonthLabel.topAnchor.constraint(equalTo: dayOfTheWeekLabel.bottomAnchor, constant: 4),
            dayOfTheMonthLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            selectorIndicator.topAnchor.constraint(equalTo: dayOfTheMonthLabel.bottomAnchor, constant: 6),
            selectorIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            selectorIndicator.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            selectorIndicator.heightAnchor.constraint(equalToConstant: 3)
        ])
    }
    
    func configureViews() {
        dayOfTheWeekLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        dayOfTheMonthLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}
