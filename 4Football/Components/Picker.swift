//
//  Picker.swift
//  4Football
//
//  Created by Gabriel Muelas on 29/08/22.
//

import UIKit

class Picker: UIStackView {
    var title: String {
        didSet {
            label.text = title
        }
    }
    var iconUrl: String? {
        didSet {
            if let iconUrl {
                image.load(from: URL(string: iconUrl))
            }
        }
    }
    var iconPlaceholder: UIImage
    
    //PAREI AQUI
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = title
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = iconPlaceholder
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        return imageView
    }()
    
    init(title: String, iconPlaceholder: UIImage, target: Any?, action: Selector?) {
        self.title = title
        self.iconPlaceholder = iconPlaceholder
        
        super.init(frame: .zero)
        _ = self.addArrangedSubviews([image, label])
        self.spacing = 10
        self.isLayoutMarginsRelativeArrangement = true
        self.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        self.layer.backgroundColor = UIColor.systemGroupedBackground.cgColor
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.oceanic.cgColor
        self.layer.borderWidth = 2
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true

        let tapGestureOrganizer = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tapGestureOrganizer)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
