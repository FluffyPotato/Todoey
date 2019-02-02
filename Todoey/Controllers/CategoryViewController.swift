//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Alice Fluffy on 2/2/19.
//  Copyright © 2019 Alice Fluffy. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoriesArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }
    
    //MARK: - TablView DataSource Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoriesArray[indexPath.row].name
        
        return cell
    }
    
    //MARK: - Data Manipulation Methods
    
    func saveCategories() {
        
        do {
            try context.save()
            
        } catch {
            print("Error saving category, \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategories() {
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
           
            categoriesArray = try context.fetch(request)
            
        } catch {
            print("Error fetching categories \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if textField.text! != "" {
                
                let newCategory = Category(context: self.context)
                
                newCategory.name = textField.text!
                
                self.categoriesArray.append(newCategory)
                
                self.saveCategories()
                
            }
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Enter new category.."
            
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - TableView Delegate Methods
    

}
