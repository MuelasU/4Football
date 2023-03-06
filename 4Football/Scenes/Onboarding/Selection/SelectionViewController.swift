//
//  SelectionViewController.swift
//  4Football
//
//  Created by Gabriel Muelas on 16/09/22.
//

import UIKit

class SelectionViewController<T: Item>: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    private let data: [T]
    
    private var searchedData: [T] = []
    private var isSearching: Bool = false
    
    private(set) var selection: T? = nil
    var onDismiss: (() -> Void)? = nil
    
    private let contentView = SelectionView()
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.searchBar.delegate = self
        contentView.tableView.register(SelectionViewCell.self, forCellReuseIdentifier: "row")
        
        view.backgroundColor = .systemBackground
    }

    init(data: [T]) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearching ? searchedData.count : data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contentView.tableView.dequeueReusableCell(withIdentifier: "row") as! SelectionViewCell
        cell.name = isSearching ? searchedData[indexPath.row].name : data[indexPath.row].name
        cell.imageUrl = isSearching ? searchedData[indexPath.row].imageUrl : data[indexPath.row].imageUrl
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection = isSearching ? searchedData[indexPath.row] : data[indexPath.row]
        dismiss(animated: true, completion: onDismiss)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        searchedData = data.filter { $0.name.lowercased().prefix(searchText.count) == searchText.lowercased()}
        contentView.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        contentView.searchBar.text = ""
        contentView.tableView.reloadData()
    }
}
