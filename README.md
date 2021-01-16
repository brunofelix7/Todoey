# Todoey

Todoey é um aplicativo desenvolvido utilizando a linguagem Swift 5, Xcode 12 e Storyboard para iPhone, que tem o objetivo de trabalhar com o banco de dados interno do aparelho. As tecnologias utilizadas são o CoreData e Realm.

###### Section 1 - Class 2. Subclassing a UITableViewController to Build a To Do List App

  - Incluimos um Table View Controller no Main.storyboard
  - Movemos a seta de inicialização da View Controller default para a nova
  - Deletamos o View Controller default
  - Refatoramos a classe ViewController para TodoListViewController e fizemos ela extender de "UITableViewController"
  - Em Custom Class adicionamos o novo controller a view
  - Clicamos na cell e em Table View Cell - Identifier adicionamos um identificador "TodoItemCell"
  - Adicionamos um Navigation Controller selecionando a Table View Controller -> Editor -> Embeded In -> Navigation Controller
  - Na barra de menu que apareceu na Table View Controller, clicamos e adicionamos o título "Todoey"
  - Em Navigation Controller Scene -> Navigation Bar, selecionamos e alteramos a cor em "Bar Tint" e a cor do texto em "Title Color"
  - No controller "TodoListViewController" criamos a constante "itemArray", depois implementamos os métodos "tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)" e "tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)"

