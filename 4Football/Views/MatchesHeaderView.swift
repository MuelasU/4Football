//
//  MatchesHeaderView.swift
//  4Football
//
//  Created by Gabriel Muelas on 15/12/21.
//

import UIKit

class MatchesHeaderView: UITableViewHeaderFooterView {
    var championship: League? {
        didSet {
            if let championship = championship {
                championshipLabel.text = championship.name
                detailLabel.text = championship.round
                championshipImage.load(from: URL(string: championship.logoUrl), placeholder: UIImage(named: "brasao"))
            }
        }
    }
    
    private lazy var championshipLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .subheadline)
        return view
    }()
    
    private lazy var detailLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .caption1)
        view.textColor = .secondaryLabel
        return view
    }()
    
    private lazy var championshipImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var parentHStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 24
        view.distribution = .fill
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var labelsVStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 2
        view.alignment = .leading
        return view
    }()
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        setupViews()
//    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MatchesHeaderView: ViewCodable {
    func buildHierarchy() {
        contentView.addSubview(
            parentHStack.addArrangedSubviews([
                championshipImage,
                labelsVStack.addArrangedSubviews([
                    championshipLabel,
                    detailLabel
                ])
            ])
        )
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            parentHStack.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            parentHStack.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            parentHStack.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            parentHStack.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            championshipImage.widthAnchor.constraint(equalToConstant: 36),
            championshipImage.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
}
