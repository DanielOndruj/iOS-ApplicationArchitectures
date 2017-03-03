//
//  RepoListViewController.swift
//  MVC
//
//  Created by Daniel on 2/4/17.
//  Copyright © 2017 STRV s.r.o. All rights reserved.
//

import UIKit

class RepoListViewController: UIViewController {
    
    var viewModel:RepoListViewModel = RepoListViewModel()
    
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

        viewModel.presenter = self
        
        viewModel.syncData()
    }
    
    func presentDetail(model: RepoModel) {
        
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            detailViewController.model = model
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

extension RepoListViewController: RepoListViewModelProtocol {
    
    func reloadData() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
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
        return viewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell!
        if let repoCell = tableView.dequeueReusableCell(withIdentifier: RepoInfoTableViewCell.cellIdentifier) as? RepoInfoTableViewCell {
            let model = viewModel.repositories[indexPath.row]
            repoCell.configure(model: model)
            cell = repoCell
        }
        
        return cell
    }
}

extension RepoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = viewModel.repositories[indexPath.row]
        presentDetail(model: model)
    }
}
