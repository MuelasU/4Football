//
//  UIImageView+loadURL.swift
//  4Football
//
//  Created by Gabriel Muelas on 27/12/21.
//

import UIKit

extension UIImage {
    static let cache = NSCache<NSString, UIImage>()

    static let crest: UIImage! = .init(named: "brasao")
}

extension UIImageView {
    private func download(from url: URL?, completion: @escaping  (UIImage) -> ()) {
        DispatchQueue.global().async {
            if let url = url,
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
                
                UIImage.cache.setObject(image, forKey: url.absoluteString as NSString)
            }
        }
    }
    
    func load(from url: URL?, placeholder: UIImage? = nil) {
        guard let url = url else {
            return
        }

        if let cachedImage = UIImage.cache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
        } else {
            if let placeholder = placeholder {
                self.image = placeholder
            }
            
            download(from: url) { downloadedImage in
                self.image = downloadedImage
            }
        }
    }
}
