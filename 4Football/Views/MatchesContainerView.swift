import UIKit

class MatchesContainerView: UIView {

    private let matchesPageView: UIView
    private let dayPickerView: UIView
    
    init(matchesPageView: UIView, dayPickerView: UIView) {
        self.matchesPageView = matchesPageView
        self.dayPickerView = dayPickerView
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MatchesContainerView: ViewCodable {
    func buildHierarchy() {
        addSubview(dayPickerView)
        addSubview(matchesPageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            dayPickerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            dayPickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dayPickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            dayPickerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),
            
            matchesPageView.topAnchor.constraint(equalTo: dayPickerView.bottomAnchor),
            matchesPageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            matchesPageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            matchesPageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureViews() {
        dayPickerView.translatesAutoresizingMaskIntoConstraints = false
        matchesPageView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .systemGroupedBackground
    }
}
