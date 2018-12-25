//
//  ViewController.swift
//  Todoey
//
//  Created by apple on 12/23/18.
//  Copyright © 2018 Jamnas. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {
    
    var listArray = ["Deposit", "Refund", "Exchange"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        cell.textLabel?.text = listArray[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    // MARK - Add New Item
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        
        var newItem = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Update", style: .default) { (action) in
            
            self.listArray.append(newItem.text!)
            
            self.tableView.reloadData()
            
            
            
                    }
        alert.addTextField { (addTextFiled) in
        addTextFiled.placeholder = "Add new item"
            newItem = addTextFiled
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil )
    }
    
        
    }


