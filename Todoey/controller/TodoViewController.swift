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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("item.plist")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        loadItem()

        
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
      
        saveitem()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // MARK - Add New Item
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Update", style: .default) { (action) in
            
            
            let newItem = item()
            newItem.title = textField.text!
            self.listArray.append(newItem)
            
            self.saveitem()
            
            
        }
        alert.addTextField { (addTextFiled) in
        addTextFiled.placeholder = "Add new item"
            textField = addTextFiled
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil )
    }
    
    func saveitem(){
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(listArray)
            try data.write(to: dataFilePath!)
        } catch{
            print("Error occured , \(error)")
        }
        
       tableView.reloadData()

    }
    
    func loadItem(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
                listArray = try decoder.decode([item].self, from: data)
            }catch
            {
               print("Decoding Errr, \(error)")
            }
        }
        
    }
        
    }


