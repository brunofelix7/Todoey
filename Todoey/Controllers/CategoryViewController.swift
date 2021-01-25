import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    //  MARK: Inicializando o Array de categories
    var categoriesArray = [Category]()
    
    //  MARK: Recupera o contexto de persistencia do Core Data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    //  MARK: TableView Datasource - Cria as rows de acordo com o tamanho do array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    //  MARK: TableView Datasource - Itera sobre o array e preenche as rows com o valor de cada iteração
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoriesArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    //  MARK: TableView Delegate - Captura a row clicada
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        saveCategories()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //  MARK: Bar Item Add - Adiciona uma nova categoria
    @IBAction func actionAddItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "Add new categories to your todo list", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default, handler: {(action) in
            let category = Category(context: self.context)
            category.name = textField.text!
            
            self.categoriesArray.append(category)
            
            self.saveCategories()
        })
        
        alert.addTextField(configurationHandler: {(alertTextField) in
            textField = alertTextField
            textField.placeholder = "Create new category"
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //  MARK: SAVE | UPDATE | DELETE - Comita as mudanças do context no SQLite
    private func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error saving data in context. \(error)")
        }
        
        tableView.reloadData()
    }
    
    //  MARK: READ - Recupera as categorias do SQLite
    private func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoriesArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context. \(error)")
        }
        
        tableView.reloadData()
    }
}
