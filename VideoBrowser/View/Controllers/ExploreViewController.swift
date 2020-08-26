//
//  ViewController.swift
//  VideoBrowser
//
//  Created by Pankaj Gaikar on 26/08/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
        
    let categoryViewModel = CategoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Explore"
        
        //Setup Tableview
        setupTableView()
        
        //Setup viewmodel to receive data/error
        categoryViewModel.categoryViewModelDelegate = self
        categoryViewModel.getCategoriesData()
    }
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoryTableViewCell.getNib(), forCellReuseIdentifier: Constants.CellIdentifiers.CategoryTableViewCellIdentifier)
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }

}

//Tableview

/*
 * No. of sections - As many as categories.
 * Why? Cz we want to show category name and it would be easier with section header.
 */
extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryViewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.CategoryTableViewCellIdentifier, for: indexPath) as! CategoryTableViewCell
        
        /*
         * Assign nodes to tableview
         * Tableview will lay the video thumbnails i.e. collection item data.
         */
        cell.nodes = categoryViewModel.categories[indexPath.section].nodes
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    /*
     * Create programatic view for table section header.
     */
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        headerView.backgroundColor = .systemBackground
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.width, height: 20))
        headerView.addSubview(titleLabel)
        titleLabel.text = categoryViewModel.categories[section].title
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        return headerView
    }
}

extension ExploreViewController: CategoryViewModelDelegate {
    
    
    func dataLoadSuccess() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func dataLoadError(error: DataError) {
        DispatchQueue.main.async {
            let alertController = UIAlertController.init(title: "Error Occurred", message: error.localizedDescription, preferredStyle: .alert)
            
            let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension ExploreViewController: VideoCellSelectionDelegate {
    
    func playCategoryVideos(with nodes: [Node], selectedIndex: Int) {
        let videosPageViewController = VideosPageViewController.initialize(with: nodes, index: selectedIndex)
        videosPageViewController.modalPresentationStyle = .fullScreen
        videosPageViewController.modalTransitionStyle = .coverVertical
        self.present(videosPageViewController, animated: true, completion: nil)
    }
    
}
