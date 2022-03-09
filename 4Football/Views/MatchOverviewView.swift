import UIKit

class MatchOverviewView: UIView {
    let match: Match
    
    init(match: Match) {
        self.match = match
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MatchOverviewView: ViewCodable {
    func buildHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func configureViews() {
        backgroundColor = .cyan
    }
}
