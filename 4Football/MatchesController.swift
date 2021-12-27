//
//  MatchesViewController.swift
//  4Football
//
//  Created by Gabriel Muelas on 13/12/21.
//

import UIKit

class MatchesController: UIViewController {
    var contentView: MatchesView = MatchesView()
    
    override func loadView() {
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Matches"
        contentView.tableView.register(MatchTableViewCell.self, forCellReuseIdentifier: "cell")
        contentView.tableView.register(MatchesHeaderView.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        
        //FIXME: - Rearranje it! Used only for testing
        FootballAPIClient.shared.send(GetMatches(by: ["date":"2021-11-21",
                                                      "season":"2021",
                                                      "league":"71"])) { response in
            
            switch response {
            case .failure(let error):
                print(error.message)
            case .success(let matchesArray):
                print(matchesArray)
            }
        }
    }
}

extension MatchesController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = contentView.tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! MatchesHeaderView
        header.championship = "Campeonato Paulista"
        return header
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contentView.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MatchTableViewCell
        cell.matchState = MatchState(rawValue: indexPath.row)
        return cell
    }
}