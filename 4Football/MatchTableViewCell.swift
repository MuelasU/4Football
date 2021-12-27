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
            hostTeamLabel.text = match?.teams.home.name
            visitorTeamLabel.text = match?.teams.away.name
        }
    }
    
    var matchState: MatchState? {
        didSet {
            if let matchState = matchState {
                let trailingView = matchState.trailingView
                trailingView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
                parentHStack.addArrangedSubview(trailingView)
                hostScoreLabel.isHidden = matchState.isScoreHidden
                visitorScoreLabel.isHidden = matchState.isScoreHidden
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
        view.text = String(7)
        view.font = .preferredFont(forTextStyle: .body)
        return view
    }()
    
    private lazy var visitorScoreLabel: UILabel = {
        let view = UILabel()
        view.text = String(0)
        view.font = .preferredFont(forTextStyle: .body)
        return view
    }()
    
    private lazy var hostTeamImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logocorinthians")
        return view
    }()
    
    private lazy var visitorTeamImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logopalmeiras")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        view.spacing = 32
        return view
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
            ])
        )
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            parentHStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            parentHStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            parentHStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            parentHStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
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
    }
}
