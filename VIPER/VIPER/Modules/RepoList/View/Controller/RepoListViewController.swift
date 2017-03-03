//
//  RepoListViewController.swift
//  MVC
//
//  Created by Daniel on 2/4/17.
//  Copyright © 2017 STRV s.r.o. All rights reserved.
//

import UIKit

// MARK: - RepoListInputInterface declaration

protocol RepoListInputInterface: class {
    
    func reloadData()
    func loadingIndicator(show: Bool)
}

// MARK: - RepoListViewController

class RepoListViewController: UIViewController {
    
    // Reference to the Presenter's interface.
    var presenter: RepoListPresenterInputInterface!
    
    class var controllerIdentifier: String {
        return String(describing: self)
    }
    
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

        presenter.updateView()
    }
}

// MARK: - RepoListInputInterface

extension RepoListViewController: RepoListInputInterface {
    
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

// MARK: - TableView stuff

extension RepoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.getDataSource().count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell!
        if let repoCell = tableView.dequeueReusableCell(withIdentifier: RepoInfoTableViewCell.cellIdentifier) as? RepoInfoTableViewCell {
            let model = self.presenter.getDataSource()[indexPath.row]
            repoCell.configure(model: model)
            cell = repoCell
        }
        
        return cell
    }
}

extension RepoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = self.presenter.getDataSource()[indexPath.row]
        presenter.didSelectRepo(model: model)
    }
}
