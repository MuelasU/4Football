//
//  MatchesContainerView.swift
//  4Football
//
//  Created by Gabriel Muelas on 11/03/22.
//

import UIKit

class MatchesContainerView: UIView {

    private let matchesPageView: UIView
    private let pageControlView: UIView
    
    init(matchesPageView: UIView, pageControlView: UIView) {
        self.matchesPageView = matchesPageView
        self.pageControlView = pageControlView
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MatchesContainerView: ViewCodable {
    func buildHierarchy() {
        addSubview(pageControlView)
        addSubview(matchesPageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            pageControlView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            pageControlView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageControlView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageControlView.heightAnchor.constraint(equalToConstant: 30),
            
            matchesPageView.topAnchor.constraint(equalTo: pageControlView.bottomAnchor),
            matchesPageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            matchesPageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            matchesPageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureViews() {
        pageControlView.translatesAutoresizingMaskIntoConstraints = false
        matchesPageView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .systemGroupedBackground
        pageControlView.backgroundColor = .cyan
    }
}
