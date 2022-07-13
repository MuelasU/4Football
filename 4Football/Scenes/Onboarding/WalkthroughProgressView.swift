//
//  WalkthroughProgressView.swift
//  4Football
//
//  Created by Gabriel Muelas on 10/06/22.
//

import UIKit

// Indicator element in top of onboarding view to tell what the current page
class WalkthroughProgressView: UIStackView {

    private class Cell: UIView {
        static private let height: CGFloat = 4
        
        var fill: Bool = false {
            didSet {
                backgroundColor = fill ? .oceanic : .tertiaryLabel
            }
        }
        
        override init(frame: CGRect = .zero) {
            super.init(frame: frame)
            heightAnchor.constraint(equalToConstant: Self.height).isActive = true
            layer.cornerRadius = 2
            backgroundColor = .tertiaryLabel
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    private(set) var progress: Int = 0 {
        //Update fill property based on progress
        didSet {
//            let lastIndexToFill = Int(floor(progress * Float(cells.count)))
//            if lastIndexToFill > -1 {
//                (0...lastIndexToFill).forEach { cells[$0].fill = true }
//            }
            let index = progress - 1
            cells.forEach { $0.fill = false }
            if index >= 0 {
                (0...index).forEach { cells[$0].fill = true }
            }
        }
    }
    
    private let numOfCells: Int
    
    private let cells: [Cell]
    
    init(total: Int) {
        self.numOfCells = total
        self.cells = (1...total).map { _ in Cell() }
        super.init(frame: .zero)
        _ = addArrangedSubviews(cells)
        axis = .horizontal
        distribution = .fillEqually
        spacing = 8
    }
    
    func update(with progress: Int) {
        guard (0...numOfCells).contains(progress) else { return }
        
        self.progress = progress
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


