import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mike", "Buy Eggos", "Destory Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //  MARK: TableView Datasource - Cria as rows de acordo com o tamanho do array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //  MARK: TableView Datasource - Itera sobre o array e preenche as rows com o valor de cada iteração
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //  MARK: TableView Delegate - Captura a row clicada
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  Retorna a row clicada e adiciona um checkmark
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
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
            self.itemArray.append(textField.text!)
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
