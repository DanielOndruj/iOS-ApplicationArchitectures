//
//  RepoListViewController.swift
//  MVC
//
//  Created by Daniel on 2/4/17.
//  Copyright © 2017 STRV s.r.o. All rights reserved.
//

import UIKit

class RepoListViewController: UIViewController {
    
    fileprivate var dataSource:[RepoModel] = []
    
    //Only for simplicity - Can be replaced by any other ProgressHUD class
    lazy var loadingOverlay: UIView = {
        let view = UIView()
        view.frame = UIScreen.main.bounds
        view.backgroundColor = UIColor.init(white: 0.0, alpha: 0.5)
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
        return view
    }()
    
    @IBOutlet var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        syncData()
    }
    
    func syncData() {
        
        loadingIndicator(show: true)
        APIService.sharedService.makeAPIRequest(urlString: "https://api.github.com/search/repositories?q=+language:swift&sort=stars&order=desc&page=1&per_page=25", completion: { [weak self] response in

            self?.loadingIndicator(show: false)
            if case Response.success(value: let data) = response {
                self?.dataSource = self?.transformDataToDataSource(data: data["items"]) ?? []
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        })
    }
    
    func transformDataToDataSource(data:AnyObject?) -> [RepoModel] {
        
        if let data = data as? [[String:AnyObject]] {
            return data.map { (dataItem) -> RepoModel in
                let newRepo = RepoModel(data: dataItem)
                return newRepo
            }
        } else {
            return []
        }
    }
    
    func loadingIndicator(show: Bool) {
        
        DispatchQueue.main.async {
            if show {
                if let win = UIApplication.shared.delegate?.window {
                    win?.addSubview(self.loadingOverlay)
                }
            } else {
                if self.loadingOverlay.superview != nil {
                    self.loadingOverlay.removeFromSuperview()
                }
            }
        }
    }
}

extension RepoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell!
        if let repoCell = tableView.dequeueReusableCell(withIdentifier: RepoInfoTableViewCell.cellIdentifier) as? RepoInfoTableViewCell {
            let model = dataSource[indexPath.row]
            repoCell.configure(model: model)
            cell = repoCell
        }
        
        return cell
    }
}

extension RepoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = dataSource[indexPath.row]
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            detailViewController.model = model
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
