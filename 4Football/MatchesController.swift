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
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Matches"
    }
}

extension MatchesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contentView.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "Hello world"
        var config = cell.defaultContentConfiguration()
        config.text = "Hello World"
        cell.contentConfiguration = config
        return cell
    }
}
