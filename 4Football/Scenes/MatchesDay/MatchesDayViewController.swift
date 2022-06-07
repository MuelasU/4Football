//
//  ViewController.swift
//  4Football
//
//  Created by Gabriel Muelas on 09/03/22.
//

import UIKit

fileprivate struct Section {
    let league: League
    var matches: [Match]
}

// gonna be the content
class MatchesDayViewController: UIViewController {

    let day: Date
    
    init(day: Date) {
        self.day = day
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Data
    var matches = [Match]() {
        didSet {
            for match in matches {
                if let sectionIndex = sections.firstIndex(where: { $0.league == match.league}) {
                    sections[sectionIndex].matches.append(match)
                } else {
                    sections.append(Section(league: match.league, matches: [match]))
                }
            }
            contentView.tableView.reloadData()
        }
    }
    
    private var sections = [Section]()
    
    // MARK: - View
    var contentView: MatchesDayView = MatchesDayView()
    
    override func loadView() {
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // QUESTION: Can it be in loadView?
        contentView.tableView.register(MatchTableViewCell.self, forCellReuseIdentifier: "cell")
        contentView.tableView.register(MatchesHeaderView.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        
        //FIXME: - Rearranje it! Used only for testing
        FootballAPIClient.shared.send(GetMatches(by: ["date":"2022-03-08",
                                                      "season":"2021",
                                                      "league":"2"])) { response in
            switch response {
            case .failure(let error):
                print(error.message)
            case .success(let matchesArray):
                self.matches = matchesArray
            }
        }

    }
}

extension MatchesDayViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = contentView.tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! MatchesHeaderView
        header.championship = sections[section].league
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contentView.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MatchTableViewCell
        cell.match = sections[indexPath.section].matches[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let match = sections[indexPath.section].matches[indexPath.row]
        navigationController?.pushViewController(MatchOverviewViewController(match: match), animated: true)
    }
}
