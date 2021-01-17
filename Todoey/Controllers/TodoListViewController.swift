import UIKit

class TodoListViewController: UITableViewController {

    //  MARK: Inicializando o Array de items
    var itemsArray = [Item]()
    
    //  MARK: Inicializando o UserDefaults (Persistência no preferences)
    let defaults = UserDefaults.standard
    
    //  MARK: Inicializando o NSCoder (Persistencia em arquivos)
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
        //  Recupera os itens do UserDefaults
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        //  Recupera o item
        let item = itemsArray[indexPath.row]
        
        //  Adiciona um label na row pelo title do item
        cell.textLabel?.text = item.title
        
        //  Adiciona o checkmark nas rows
        cell.accessoryType = item.isDone ? .checkmark : .none
        
        return cell
    }
    
    //  MARK: TableView Delegate - Captura a row clicada
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  Quando o item é clicado, o isDone recebe o oposto (se true recebe false, se false recebe true)
        itemsArray[indexPath.row].isDone = !itemsArray[indexPath.row].isDone
        
        self.saveItems()
        
        //  Adiciona uma animação de clique na row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //  MARK: Bar Item Add - Adiciona novos itens
    @IBAction func actionAddItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        //  Cria um popup de alerta na tela
        let alert = UIAlertController(title: "Add New Todoey Item", message: "Adds new itens to your todo list.", preferredStyle: .alert)
        
        //  Cria uma ação para o alert e adiciona um novo item
        let action = UIAlertAction(title: "Add Item", style: .default, handler: {(action) in
            let item = Item()
            item.title = textField.text!
            
            self.itemsArray.append(item)
            
            //self.defaults.set(self.itemsArray, forKey: "TodoListObj")
            
            self.saveItems()
        })
        
        //  Adiciona um campo de input no alert
        alert.addTextField { (alertTextField) in
            textField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        //  Adiciona a action para o alert
        alert.addAction(action)
        
        //  Exibe na tela o alert com a action
        present(alert, animated: true, completion: nil)
    }
    
    //  MARK: Salva os items no diretório documentDirectory com NSCoder
    private func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemsArray)
            try data.write(to: dataFilePath!)
            
            print(dataFilePath!)
        } catch {
            print("Error encoding item array. \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    //  MARK: Recupera os dados no diretório documentDirectory com NSCoder
    private func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            
            do {
                itemsArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array. \(error)")
            }
        }
    }
    
}
