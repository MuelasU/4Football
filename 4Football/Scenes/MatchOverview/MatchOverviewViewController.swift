import UIKit

class MatchOverviewViewController: UIViewController {
    let contentView: MatchOverviewView
    let match: Match
    
    init(match: Match) {
        self.match = match
        contentView = MatchOverviewView(match: match)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(match.teams.home.name) x \(match.teams.away.name)"
    }
}
