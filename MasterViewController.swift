//
//  MasterViewController.swift
//  masterDetailTemplateXCode11
//
//  Created by R.O. Chapman on 11/18/20.
//  Copyright © 2020 R.O. Chapman. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [String]()
    var selectedItem = 0
    var detailDescriptionObj = [String]()
    
    var index = 0
    var detail: [[String:String]] = []
    
    //From Lecture
    func dataFileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var url:URL?
        url = URL(fileURLWithPath: "")
        url = urls.first!.appendingPathComponent("data.plist")
        return url!
    }

    override func viewDidLoad() {
        title = "FitList"
        super.viewDidLoad()
        print(selectedItem)
        print("\(NSHomeDirectory())")
        
        //https://developer.apple.com/documentation/uikit/uicolor/standard_colors
        view.backgroundColor = .systemOrange
        navigationController?.navigationBar.barTintColor = UIColor.orange
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
            navigationItem.rightBarButtonItem = addButton
 
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }

    let fileURL = self.dataFileURL()
        
    if (FileManager.default.fileExists(atPath: fileURL.path)) {
        print("found file")
        detail = (NSArray(contentsOf: fileURL as URL) as? [[String:String]])!
        }
    else {
        if let URL = Bundle.main.url(forResource: "Property List", withExtension: "plist") {
            if let arrayFromPlist = NSArray(contentsOf: URL) as? [Dictionary<String, String>] {
                detail = arrayFromPlist
            }
        }
    }
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(notification:)), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    //From Lecture
    @objc func applicationWillResignActive(notification:NSNotification) {
        print("saved data")
        let fileURL = self.dataFileURL()
        let array = (self.detail as NSArray)
        array.write(to: fileURL as URL, atomically: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @objc
    func insertNewObject(_ sender: Any) {
            objects.insert("New Item", at: 0)
            print("ran insert"+objects[0])
        
            let newItem = ["Name": "New Exercise", "Detail": ""]
            detail.insert(newItem, at: 0)
        
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                index = indexPath.row
            }
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
                detailViewController!.masterController = self
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detail.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = detail[indexPath.row]["Name"]
        selectedItem = indexPath.row
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    //https://stackoverflow.com/questions/30679701/ios-swift-how-to-change-background-color-of-table-view/30679834
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .systemGray4
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           // objects.remove(at: indexPath.row)
            detail.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            //detail.remove(at: indexPath.row)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}
