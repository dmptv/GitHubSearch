//
//  SearchCollectionViewController.swift
//  GitHubSearch
//
//  Created by 123 on 22.05.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class SearchCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchBar: UISearchBar!
    var searchSettings = SearchResult()
    var seachingPage = 0
    var isBatchFetching = false
    var requestCancelled = false
    var progressHUD: MBProgressHUD?
    
    var repos: [GithubRepo]! {
        didSet{
            collectionView.reloadData()
        }
    }
    
    fileprivate(set) var state: State = .notSearchedYet
    fileprivate var dataTask: DataRequest? = nil
    
    // TODO: - abstract away all Searchung to Object

    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressHUD = MBProgressHUD.init(view: view)
        progressHUD?.removeFromSuperViewOnHide = true
        progressHUD?.center = view.center
        
        setupFlowLayout()
        showBannerView()
        setupSearchBar()
        
    }
    
    private func setupFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 10, right: 16)
        var itmeWidth = (collectionView.frame.width/2)-21
        if view.frame.width == 320 {
            itmeWidth = (collectionView.frame.width/2)-48
        }
        layout.itemSize = CGSize(width: itmeWidth, height: itmeWidth+20)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        collectionView.collectionViewLayout = layout
    }
    
    private func showBannerView() {
        Global.bannerView()
    }
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search Top Repos"
        searchBar.backgroundColor = .mainBlue()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.collectionView.visibleCells.forEach{transform(cell: $0)}
    }

}

extension SearchCollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if repos != nil {
            return repos.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionShow", for: indexPath) as! ShowCollectionCell

        if indexPath.item < repos.count {
            cell.repo = repos[indexPath.row]
        }
        
        transform(cell: cell)
        return cell
    }
    
    fileprivate func transform(cell: UICollectionViewCell) {
        Global.transform(cell: cell, view: view, collectionView: collectionView)
    }

}

extension SearchCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "showDetails") as! ShowDetailsViewController
        vc.repo = repos[indexPath.row]
        self.present(vc, animated: false, completion: nil)
        collectionView.deselectItem(at: indexPath, animated: false)
    }
     
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if repos != nil {
            if indexPath.row == repos.count - 1 {
                doSearch()
            }
        }
    }

}

extension SearchCollectionViewController: UISearchBarDelegate {
    
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
        dataTask?.cancel()
        afterDelay(0) { [weak self] in
            self?.progressHUD?.hide(animated: false)
        }
        seachingPage = 1
        doSearch()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar.endEditing(true)
    }
    
    private func doSearch() {
        seachRepos(searchStr: searchSettings.searchString ?? "")
    }
    
    private func seachRepos(searchStr: String) {
        
        seachingPage += 1
        
        if !searchStr.isEmpty {
            state = .loading
            if isBatchFetching {
//                seachingPage += 1
            } else {
                // first page
//                seachingPage = 1
                    afterDelay(0) {
                        self.view.addSubview(self.progressHUD!)
                        self.progressHUD?.show(animated: false)
                    }
            }
            
            let query = searchStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            dataTask = Alamofire.request(GithubRouter.search(query, seachingPage))
                .responseJSON { [weak self] response in
                    
                    guard let strongSelf = self else { return }
                    afterDelay(0, closure: {
                        strongSelf.progressHUD?.hide(animated: false)
                    })

                    guard response.result.isSuccess, let value = response.result.value
                        else {
                            if (response.result.error! as NSError).code == -999 {
                                printMine("request cancelled")
                                return
                            } else {
                                networkError(response.result.error!)
                            }
                            return }
                    
                    if strongSelf.isBatchFetching {
                        var fetchedRepos: [GithubRepo] = []
                        if let results = (value as! Json)["items"] as? [Json] {
                            fetchedRepos = results.compactMap { json in
                                GithubRepo(jsonResult: json) }
                        }
                        strongSelf.repos.append(contentsOf: fetchedRepos)
                        
                    } else {
                        // first page
                        strongSelf.isBatchFetching = true
                        if let results = (value as! Json)["items"] as? [Json] {
                            strongSelf.repos = []
                            strongSelf.repos = results.compactMap { json in
                                GithubRepo(jsonResult: json)
                            }
                        }
                    }
        
                    afterDelay(0.25, closure: {
                        strongSelf.collectionView.reloadData()
                    })
            }
        }
    }
    

}















