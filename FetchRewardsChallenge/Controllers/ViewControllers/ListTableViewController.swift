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
    
//    var outings: [Outing] = [] {
//        didSet {
//            outings.sort(by: { $0.date > $1.date })
//            favoriteOutings = outings.filter( { $0.isFavorite } )
//        }
//    }
//
//    var favoriteOutings: [Outing] {
//        get {
//            outings.filter( { $0.isFavorite })
//        } set {
//        }
//    }
    
//    var fetchedItems = [Item]() {
//        didSet {
//
//            fetchedItems.removeAll(where: { $0.name == nil || $0.name == "" })
//
//
//            for item in fetchedItems {
//                if item.name != nil && item.name != "" {
//                    //items.append(item)
//                }
//            }
//            items.sort(by: { $0.listID < $1.listID } )
//        }
//    }
    
    var listIDs = [Int]()
    
    var lists = [List]()

    var items = [Item]() {
        didSet {
            items.removeAll(where: { $0.name == nil || $0.name == "" })
            
            for item in items {
                if !listIDs.contains(item.listID) {
                    listIDs.append(item.listID)
                    ListController.shared.create(id: item.listID)
                }
            }
            listIDs.sort(by: { $0 < $1 })
            ListController.shared.lists.sort(by: { $0.id < $1.id })
            
            for item in items {
                ListController.shared.addItem(item: item)
            }
            
            for list in ListController.shared.lists {
                list.items.sort(by: <)
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
        // #warning Incomplete implementation, return the number of rows
        return listIDs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)

        let list = ListController.shared.lists[indexPath.row]
        cell.textLabel?.text = "List ID: \(list.id)"

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToItemTVC" {
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? ItemTableViewController else { return }
            let list = ListController.shared.lists[indexPath.row]
            destinationVC.list = list
        }
    }

} //End
