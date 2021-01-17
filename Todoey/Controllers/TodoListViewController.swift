import UIKit

class TodoListViewController: UITableViewController {

    var itemsArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Buy new Macbook M1"
        itemsArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy iPhone 11"
        itemsArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Buy Playstation 5"
        itemsArray.append(newItem3)
        
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
        
        tableView.reloadData()
        
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
            
            self.defaults.set(self.itemsArray, forKey: "TodoListObj")
            
            self.tableView.reloadData()
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
    
}