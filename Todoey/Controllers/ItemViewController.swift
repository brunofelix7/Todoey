import UIKit
import CoreData

class ItemViewController: UITableViewController {

    //  MARK: Inicializando o Array de items
    var itemsArray = [Item]()
    
    //  MARK: Inicializando o UserDefaults (Persistência no preferences)
    let defaults = UserDefaults.standard
    
    //  MARK: Inicializando o NSCoder (Persistencia em arquivos)
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    //  MARK: Recupera o contexto de persistencia do Core Data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        loadItems()
        
        //  MARK: OLD CODE - Recupera os itens do UserDefaults
//        if let items = defaults.array(forKey: "TodoListObj") as? [Item] {
//            itemsArray = items
//        }
    }

    //  MARK: TableView Datasource - Cria as rows de acordo com o tamanho do array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    //  MARK: TableView Datasource - Itera sobre o array e preenche as rows com o valor de cada iteração
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //  Recupera a row pelo identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        //  Recupera o item
        let item = itemsArray[indexPath.row]
        
        //  Adiciona um label na row pelo title do item
        cell.textLabel?.text = item.title
        
        //  Adiciona o checkmark nas rows
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //  MARK: TableView Delegate - Captura a row clicada
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  Quando o item é clicado, o isDone recebe o oposto (se true recebe false, se false recebe true)
        itemsArray[indexPath.row].done = !itemsArray[indexPath.row].done
        
        //  MARK: UPDATE - Caso eu queira atualizar alguma propriedade
        //itemsArray[indexPath.row].setValue("Completed", forKey: "title")
        
        //  MARK: DELETE - Remove o item selecionado
        //context.delete(itemsArray[indexPath.row])
        //itemsArray.remove(at: indexPath.row)
        
        saveItems()
        
        //  Adiciona uma animação de clique na row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //  MARK: Bar Item Add - Adiciona novos itens
    @IBAction func actionAddItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        //  Cria um popup de alerta na tela
        let alert = UIAlertController(title: "Add New Todoey Item", message: "Adds new itens to your todo list.", preferredStyle: .alert)
        
        //  Cria uma ação para o alert e adiciona um novo item
        let action = UIAlertAction(title: "Add", style: .default, handler: {(action) in
            //  Cria um novo item
            let item = Item(context: self.context)
            item.title = textField.text!
            item.done = false
            
            self.itemsArray.append(item)
            
            //  MARK: OLD CODE - Recupera os dados do UserDefaults
            //self.defaults.set(self.itemsArray, forKey: "TodoListObj")
            
            self.saveItems()
        })
        
        //  Adiciona um campo de input no alert
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            textField.placeholder = "Create new item"
        }
        
        //  Adiciona a action para o alert
        alert.addAction(action)
        
        //  Exibe na tela o alert com a action
        present(alert, animated: true, completion: nil)
    }
    
    //  MARK: SAVE | UPDATE | DELETE - Comita as mudanças do context no SQLite
    private func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving data in context. \(error)")
        }
        
        tableView.reloadData()
    }
    
    //  MARK: READ - Recupera os items do SQLite
    private func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            itemsArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context. \(error)")
        }
        
        tableView.reloadData()
    }
    
    //  MARK: OLD CODE - Salva os items no diretório documentDirectory com NSCoder
//    private func saveItems() {
//        let encoder = PropertyListEncoder()
//
//        do {
//            let data = try encoder.encode(itemsArray)
//            try data.write(to: dataFilePath!)
//
//            print(dataFilePath!)
//        } catch {
//            print("Error encoding item array. \(error)")
//        }
//
//        self.tableView.reloadData()
//    }
    
    //  MARK: OLD CODE - Recupera os dados no diretório documentDirectory com NSCoder
//    private func loadItems() {
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//
//            do {
//                itemsArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("Error decoding item array. \(error)")
//            }
//        }
//    }
}

//  MARK: Extensão para a SearchBar
extension ItemViewController : UISearchBarDelegate {
    
    //  MARK: Método de callback quando um texto é pesquisado
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
                
        loadItems(with: request)
    }
    
    //  MARK: Método de callback quando o texto da SearchBar é alterado
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            //  MARK: Retorna a SearchBar para o estado inicial em background
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}
