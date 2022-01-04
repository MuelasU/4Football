//
//  UIImageView+loadURL.swift
//  4Football
//
//  Created by Gabriel Muelas on 27/12/21.
//

import UIKit

extension UIImageView {
    func load(from url: URL?, placeholder: UIImage? = nil) {
        if let placeholder = placeholder {
            self.image = placeholder
        }
        
        DispatchQueue.global().async { [weak self] in
            if let url = url,
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
