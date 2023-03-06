//
//  SelectionViewCell.swift
//  4Football
//
//  Created by Gabriel Muelas on 17/09/22.
//

import UIKit

class SelectionViewCell: UITableViewCell, ViewCodable {
    var name: String? {
        didSet {
            label.text = name
        }
    }
    var imageUrl: String? {
        didSet {
            if let imageUrl {
                leadingImage.load(from: URL(string: imageUrl), placeholder: UIImage(named: "brasao"))
            }
        }
    }

    private lazy var label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .body)
        return view
    }()
    
    private lazy var leadingImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()

    func buildHierarchy() {
        addSubview(leadingImage)
        addSubview(label)
    }
    
    func setupConstraints() {
        self.layoutMargins = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        NSLayoutConstraint.activate([
            leadingImage.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            leadingImage.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            leadingImage.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            leadingImage.heightAnchor.constraint(equalToConstant: 32),
            leadingImage.widthAnchor.constraint(equalToConstant: 32),
            
            label.leadingAnchor.constraint(equalTo: leadingImage.trailingAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            label.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor)
        ])
    }
    
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
}
