//
//  Picker.swift
//  4Football
//
//  Created by Gabriel Muelas on 29/08/22.
//

import UIKit

class Picker: UIStackView {
    var picked: Item? = nil {
        didSet {
            if let picked {
                label.text = picked.name
                if let url = picked.imageUrl {
                    image.load(from: URL(string: url))
                }
            }
            else {
                label.text = text
                image.image = iconPlaceholder
            }
        }
    }

    let text: String
    let iconPlaceholder: UIImage

    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = text
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
    
    init(text: String, iconPlaceholder: UIImage, target: Any?, action: Selector?) {
        self.text = text
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

    func clear() {
        picked = nil
    }
}
