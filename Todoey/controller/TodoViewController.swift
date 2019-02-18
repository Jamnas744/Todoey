//
//  ViewController.swift
//  Todoey
//
//  Created by apple on 12/23/18.
//  Copyright © 2018 Jamnas. All rights reserved.
//

import UIKit
import CoreData

class TodoViewController: UITableViewController {
    
    var listArray = [Item]()
    
    var selectedCategory : Category?{
        didSet{
            loadItem()
        }
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("item.plist")
//
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        

        
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
        
        context.delete(listArray[indexPath.row])
        listArray.remove(at: indexPath.row)
        
        listArray[indexPath.row].done = !listArray[indexPath.row].done
      
        saveitem()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // MARK - Add New Item
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Update", style: .default) { (action) in
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parantCategory = self.selectedCategory
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
        
        
        do {
            try context.save()
        } catch{
            print("Error saving contex, \(error)")
        }
        
       tableView.reloadData()

    }
    
    func loadItem(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil){

        let categoryPredicate = NSPredicate(format: "parantCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates:[categoryPredicate, additionalPredicate])
        }else{
            request.predicate = categoryPredicate
        }
        
    
        do {
            listArray = try context.fetch(request)
        }
        catch{
            print("Error handler \(error)")
        }
   tableView.reloadData()
    }
    
    
    }
//MARK: - SearchBar metode
extension TodoViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
      loadItem(with: request, predicate: predicate)
  
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            
            loadItem()
            
            DispatchQueue.main.async{
                searchBar.resignFirstResponder()

            }
            
        }
    }

}

