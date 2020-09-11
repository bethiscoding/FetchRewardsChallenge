//
//  ItemListTableViewController.swift
//  FetchRewardsChallenge
//
//  Created by Bethany Morris on 9/9/20.
//  Copyright © 2020 Bethany M. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var items = [Item]() {
        didSet {
            items.removeAll(where: { $0.name == "" })
            
            for item in items {
                ///Check to see if list exists for that item. If not, create new List
                if !ListController.shared.lists.contains(where: { $0.id == item.listID }) {
                    ListController.shared.create(id: item.listID)
                }
            }
            ///Sort lists for UI
            ListController.shared.lists.sort(by: { $0.id < $1.id })
            
            ///Once all lists are created/sorted, add items to corresponding list
            for item in items {
                ListController.shared.addItem(item: item)
            }
            
            ///Sort items within each list for UI
            for list in ListController.shared.lists {
                list.items.sort(by: { $0.name.localizedStandardCompare($1.name) == .orderedAscending })
            }
        }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    // MARK: - Methods
    
    func setUpViews() {
        ItemController.fetchItems { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    self.items = items
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.errorDescription ?? "Oops! It looks like there was an error!")
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListController.shared.lists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)

        let list = ListController.shared.lists[indexPath.row]
        cell.textLabel?.text = "List ID: \(list.id)"

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToItemTVC" {
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? ItemTableViewController else { return }
            let list = ListController.shared.lists[indexPath.row]
            destinationVC.list = list
        }
    }

} //End
