import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Find Mike", "Buy Eggos", "Destory Demogorgon"]
    
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
        //  Retorna a row clicada
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        //  Adiciona uma animação de clique nas rows
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
