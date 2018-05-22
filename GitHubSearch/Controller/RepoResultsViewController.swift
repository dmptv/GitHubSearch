//
//  ViewController.swift
//  GitHubSearch
//
//  Created by 123 on 21.05.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire

// FIXME: - keep track 
enum State {
    case notSearchedYet
    case loading
    case noResults
    case results([GithubRepo])
}

class RepoResultsViewController: UIViewController {
    
    enum RepoVCCells: String {
        case githubCell = "githubCell"
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.estimatedRowHeight = 150
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    var searchBar: UISearchBar!
    var searchSettings = SearchResult()
    var seachingPage = 1
    var isBatchFetching = false
    
    var repos: [GithubRepo]! {
        didSet{
            tableView.reloadData()
        }
    }
    
    fileprivate(set) var state: State = .notSearchedYet
    fileprivate var dataTask: DataRequest? = nil
    
    deinit {
        print("deinited: \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loadingNib = UINib(nibName: "LoadingCell", bundle: nil)
        tableView.register(loadingNib, forCellReuseIdentifier: "loadingCell")
        
        setupSearchBar()
    }

    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
    }
    
    private func doSearch() {
        seachRepos(searchStr: searchSettings.searchString ?? "")
    }
    
    private func seachRepos(searchStr: String) {
        
        if !searchStr.isEmpty {
            dataTask?.cancel()
            state = .loading
           
            if isBatchFetching {
                seachingPage += 1
            } else {
                seachingPage = 1
                MBProgressHUD.showAdded(to: view, animated: true)
            }
            
            print(isBatchFetching)
            
            dataTask = Alamofire.request(GithubRouter.search(searchStr, seachingPage))
                .responseJSON { [weak self] response in
                    guard response.result.isSuccess,
                        let value = response.result.value else {
                            print("Error while fetching colors: \(String(describing: response.result.error))")
                            return
                    }
                    
                    if (self?.isBatchFetching)! {
                        var fetchedRepos: [GithubRepo] = []
                        if let results = (value as! Json)["items"] as? [Json] {
                            fetchedRepos = results.compactMap { json in
                                GithubRepo(jsonResult: json) }
                        }
                        self?.repos.append(contentsOf: fetchedRepos)
                        
                    } else {
                        // first page
                        if let results = (value as! Json)["items"] as? [Json] {
                            self?.repos = []
                            self?.repos = results.compactMap { json in
                                GithubRepo(jsonResult: json)
                            }
                            
                            self?.isBatchFetching = true
                            MBProgressHUD.hide(for: (self?.view!)!, animated: true)
                        }
                    }
      
                    print(self?.seachingPage as Any)
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
            }
        }
    }

}

extension RepoResultsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if repos != nil {
            return repos.count
        }
        
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoVCCells.githubCell.rawValue,
                                                 for: indexPath as IndexPath) as! GithubCell
        cell.authorImageView.image = nil
        cell.repo = repos[indexPath.row]
        return cell
    }
}

extension RepoResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if repos != nil {
            let lastItem = repos.count - 1
            if indexPath.row == lastItem {
                doSearch()
            }
        }
    }
}

extension RepoResultsViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        isBatchFetching = false
        doSearch()
    }
}

















