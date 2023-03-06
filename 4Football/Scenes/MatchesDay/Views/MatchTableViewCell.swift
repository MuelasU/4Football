//
//  MatchTableViewCell.swift
//  4Football
//
//  Created by Gabriel Muelas on 14/12/21.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    var match: Match? {
        didSet {
            if let match = match {
                hostTeamLabel.text = match.teams.home.name
                hostScoreLabel.text = String(match.goals.home ?? 0)
                hostTeamImage.load(from: URL(string: match.teams.home.imageUrl!),
                                   placeholder: UIImage(named: "brasao"))
                
                visitorTeamLabel.text = match.teams.away.name
                visitorScoreLabel.text = String(match.goals.away ?? 0)
                visitorTeamImage.load(from: URL(string: match.teams.away.imageUrl!),
                                   placeholder: UIImage(named: "brasao"))
                
                self.highlightWinner(from: match)
                [hostScoreLabel, visitorScoreLabel].forEach { label in
                    label.isHidden = !match.fixture.status.hasScore
                }
                statusView.matchInfo = match.fixture
            }
        }
    }
    
    private lazy var parentHStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 32
        view.isLayoutMarginsRelativeArrangement = true
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var hostTeamHStack: UIStackView = createTeamHStack()
    
    private lazy var visitorTeamHStack: UIStackView = createTeamHStack()
    
    private lazy var teamsVStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 16
        return view
    }()
    
    private lazy var hostTeamLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .body)
        return view
    }()
    
    private lazy var visitorTeamLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .body)
        return view
    }()
    
    private lazy var hostScoreLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .body)
        return view
    }()
    
    private lazy var visitorScoreLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .body)
        return view
    }()
    
    private lazy var hostTeamImage: UIImageView = createTeamImage()
    
    private lazy var visitorTeamImage: UIImageView = createTeamImage()
    
    private lazy var statusView: MatchStatusView = MatchStatusView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createTeamHStack() -> UIStackView {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 24
        return view
    }
    
    private func createTeamImage() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func highlightWinner(from match: Match) {
        [hostScoreLabel, hostTeamLabel].forEach { label in
            label.font = .preferredFont(forTextStyle: (match.teams.home.winner ?? false ? .headline : .body))
        }
        
        [visitorScoreLabel, visitorTeamLabel].forEach { label in
            label.font = .preferredFont(forTextStyle: (match.teams.away.winner ?? false ? .headline : .body))
        }
    }
}

extension MatchTableViewCell: ViewCodable {
    func buildHierarchy() {
        addSubview(
            parentHStack.addArrangedSubviews([
                teamsVStack.addArrangedSubviews([
                    hostTeamHStack.addArrangedSubviews([
                        hostTeamImage,
                        hostTeamLabel,
                        hostScoreLabel
                    ]),
                    visitorTeamHStack.addArrangedSubviews([
                        visitorTeamImage,
                        visitorTeamLabel,
                        visitorScoreLabel
                    ])
                ]),
                statusView
            ])
        )
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            parentHStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            parentHStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            parentHStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            parentHStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            hostTeamImage.widthAnchor.constraint(equalToConstant: 32),
            hostTeamImage.heightAnchor.constraint(equalToConstant: 32),
            visitorTeamImage.widthAnchor.constraint(equalToConstant: 32),
            visitorTeamImage.heightAnchor.constraint(equalToConstant: 32),
            statusView.widthAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func configureViews() {
        backgroundColor = .secondarySystemGroupedBackground
        
        visitorTeamLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        hostTeamLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        visitorTeamImage.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        hostTeamImage.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        visitorScoreLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        hostScoreLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        teamsVStack.setContentHuggingPriority(.defaultLow, for: .horizontal)
        statusView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        hostScoreLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        visitorScoreLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    func applyAccessibility() {
        accessibilityTraits.insert(.button)
    }
}
