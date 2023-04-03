import UIKit

class MatchOverviewView: UIView {
    let match: Match
    
    init(match: Match) {
        self.match = match
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var scoreView: ScoreView = .init(match: match)
}

extension MatchOverviewView: ViewCodable {
    func buildHierarchy() {
        addSubview(scoreView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scoreView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scoreView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scoreView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    func configureViews() {
        backgroundColor = .systemBackground
    }
}
