//
//  NewConversationViewController.swift
//  Bonfire
//
//  Created by Eric Chen on 4/4/22.
//

import UIKit
import JGProgressHUD

class NewConversationViewController: UIViewController {

    public var completion: (([String: String]) -> (Void))?
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private var users = [[String: String]]()
    private var hasFetched = false
    private var results = [[String: String]]()
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for Users..."
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let noResultsFoundLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "No Results Found"
        label.textAlignment = .center
        label.textColor = .green
        label.font = .systemFont(ofSize: 21, weight: .medium)
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(noResultsFoundLabel)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(dismissSelf))
        
        searchBar.becomeFirstResponder()
        
    }
    
    @objc private func dismissSelf(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        noResultsFoundLabel.frame = CGRect(x: view.width/4,
                                           y: (view.height-200)/2,
                                           width: view.width/2,
                                           height: 200)
    }
    
    
}

extension NewConversationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = results[indexPath.row]["name"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        let targetUserData = results[indexPath.row]
        
        dismiss(animated:true, completion: { [weak self] in
            self?.completion?(targetUserData)
        })
    }
}

extension NewConversationViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        searchBar.resignFirstResponder()
        results.removeAll()
        spinner.show(in: view)
        
        self.searchUsers(query: text)
    }
    
    func searchUsers(query: String){
        //check presence of array
        if hasFetched {
            //filter
            filterUsers(with: query)
        } else {
            //update
            
            DatabaseManager.shared.getAllUsers(completion: {[weak self] result in
                switch result {
                case .success(let usersColllection):
                    self?.hasFetched = true
                    self?.users = usersColllection
                    self?.filterUsers(with: query)
                case .failure(let error):
                    print("Failed to get users: \(error)")
                
                }
            })
        }
        
        //if we do filter results, if not fetch from firebase
        // We do this to reduce the number of times its needed to query from firebase
  
    }
    
    func filterUsers(with term: String){
        guard hasFetched else {
            return
        }
        
        self.spinner.dismiss()
        
        let results: [[String: String]] = self.users.filter({
            guard let name = $0["name"]?.lowercased() else {
                return false
            }
            
            return name.hasPrefix(term.lowercased())
        })
        
        self.results = results
        updateUI()
        
    }
    
    
    // Update Search results for the case of users or no users based on filtering
    func updateUI(){
        if results.isEmpty {
            self.noResultsFoundLabel.isHidden = false
            self.tableView.isHidden = true
        } else {
            self.noResultsFoundLabel.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
}
