//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by apple on 2/4/19.
//  Copyright © 2019 Jamnas. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    
    var myArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
  
    }
    
    //MARK: - Tableview Datasource
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let item = myArray[indexPath.row]
        cell.textLabel?.text = item.name
        
        return cell
        
    }
    
    
    //MARK: - Tableview Delegate methode
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoViewController
        
        if  let indexpath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = myArray[indexpath.row]
            
        }
        
    }
    
    //MARK: - Save your Data
    
    func saveItem() {
        do {
            try context.save()
        }
        catch{
            print("Error while saving coreData \(error)")
        }
        
        tableView.reloadData()
    }
    
    //MARK: - Load Data
    
    func loadData() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do{
            myArray = try context.fetch(request)
        }
        
        catch{
            print("Getting error while loadData\(error)")
        }
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
         var textFiled = UITextField()
        
        let alert = UIAlertController(title: "Add your item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Update", style: .default) { (UIAlertAction) in
            
            let newItem = Category(context: self.context)
            newItem.name = textFiled.text!
            self.myArray.append(newItem)
            
            self.saveItem()
            
            
        }
        
        
        
        alert.addTextField { (addUITextField) in
        addUITextField.placeholder = "Add Your utem here..!"
        textFiled = addUITextField
        }
        
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }

        
}



