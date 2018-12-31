//
//  ViewController.swift
//  Todoey
//
//  Created by apple on 12/23/18.
//  Copyright © 2018 Jamnas. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {
    
    var listArray = [item]()
    
    let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = item()
        newItem.title = "Deposit"
        listArray.append(newItem)
        
        let newItem1 = item()
        newItem1.title = "Exchange"
        listArray.append(newItem1)
        
        let newItem2 = item()
        newItem2.title = "Refund"
        listArray.append(newItem2)
        if let item = defaults.array(forKey: "TodoCellArray") as? [item]{
            listArray = item
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
    
        
        let item = listArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        // Ternery operator
        // value = condition ? valueiftrue : valueifFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        listArray[indexPath.row].done = !listArray[indexPath.row].done
      
        tableView.reloadData()
        
    }
    
    // MARK - Add New Item
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Update", style: .default) { (action) in
            
            
            let newItem = item()
            newItem.title = textField.text!
            self.listArray.append(newItem)
            
            self.defaults.set(self.listArray, forKey: "TodoCellArray")
            
            self.tableView.reloadData()
            
            
            
                    }
        alert.addTextField { (addTextFiled) in
        addTextFiled.placeholder = "Add new item"
            textField = addTextFiled
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil )
    }
    
        
    }


