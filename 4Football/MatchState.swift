//
//  MatchState.swift
//  4Football
//
//  Created by Gabriel Muelas on 15/12/21.
//

import UIKit

enum MatchState: Int {
    case finished, ongoing, scheduled
    
    var isScoreHidden: Bool {
        get {
            switch self {
            case .scheduled:
                return true
            default:
                return false
            }
        }
    }
    
    var trailingView: UIView {
        switch self {
        case .finished:
            return {
                let view = UILabel()
                view.text = "Fim"
                view.textColor = .secondaryLabel
                view.font = .preferredFont(forTextStyle: .subheadline)
                return view
            }()
        case .ongoing:
            return {
                let view = UILabel()
                view.text = "20'"
                view.font = .preferredFont(forTextStyle: .headline)
                view.textColor = .oceanic
                return view
            }()
        case .scheduled:
            return {
                let view = UILabel()
                let fmt = DateFormatter()
                fmt.dateStyle = .none
                fmt.timeStyle = .short
                fmt.locale = Locale(identifier: "pt_BR")
                view.text = fmt.string(from: Date())
                view.font = .preferredFont(forTextStyle: .headline)
                return view
            }()
        }
    }
}
