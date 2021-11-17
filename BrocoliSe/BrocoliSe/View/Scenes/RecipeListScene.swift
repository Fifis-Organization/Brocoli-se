//
//  RecipeListScene.swift
//  BrocoliSe
//
//  Created by Larissa Uchoa on 09/11/21.
//

import UIKit

struct RecipeCellModel {
    var id, name, portions, time: String
    var ingredients, steps: [String]
    var pathPhoto: UIImage
}

class RecipeListScene: UIView {

    private var controller: RecipeListViewController?
    private var isSearch: Bool = false
    private var isActiveKeyboard: Bool = false
    private var recipes: [RecipeCellModel] = [] {
        didSet {
             self.tableView.reloadData()
        }
    }

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.allowsSelection = false
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.register(RecipeListCell.self, forCellReuseIdentifier: RecipeListCell.identifier)
        return table
    }()

    private lazy var searchBar: SearchBar = {
        let search = SearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.searchTextField.attributedPlaceholder = NSAttributedString(string: "Pesquisar",
                                                                          attributes: [NSAttributedString.Key.foregroundColor : UIColor.greenMedium ?? .gray])
        search.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        search.isTranslucent = true
        search.searchTextField.layer.masksToBounds = false
        search.searchTextField.layer.cornerRadius = 20
        search.searchTextField.clipsToBounds = true
        search.backgroundColor = UIColor.clear
        search.tintColor = .greenMedium
        search.barTintColor = .backgroundColor
        search.clearButtonImage = UIImage(systemName: "x.circle.fill")
        search.clearButtonColor = (.greenMedium ?? .gray)
        search.delegate = self
        
        return search
    }()

    private let whiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        view.layer.cornerRadius  = 20
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBlueDarkView()
        setupWhiteView()
        setupKeyboardGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupKeyboardGesture() {
        let tapDismiss = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide(notification:)))
        addGestureRecognizer(tapDismiss)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            isActiveKeyboard = true
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        isActiveKeyboard = false
        searchBar.resignFirstResponder()
    }

    private func setupBlueDarkView() {
        addSubview(searchBar)
        self.backgroundColor = .blueDark

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupWhiteView() {
        addSubview(whiteView)
        whiteView.addSubview(tableView)
        NSLayoutConstraint.activate([
            whiteView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 30),
            whiteView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            whiteView.leftAnchor.constraint(equalTo: self.leftAnchor),
            whiteView.rightAnchor.constraint(equalTo: self.rightAnchor),

            tableView.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 30),
            tableView.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor)
        ])
    }
}

extension RecipeListScene: RecipeListSceneDelegate {
    func setRecipes(recipes: [RecipeModel]) {
        recipes.forEach { model in
            ApiManager.downloaded(from: model.pathPhoto) { image in
                self.recipes.append(RecipeCellModel(id: model.id,
                                                    name: model.name,
                                                    portions: model.portions,
                                                    time: model.time,
                                                    ingredients: model.ingredients,
                                                    steps: model.steps,
                                                    pathPhoto: image))
            }
        }
    }
    
    func setController(controller: RecipeListViewController) {
        self.controller = controller
    }

    func reloadTable() {
        self.tableView.reloadData()
    }
}

extension RecipeListScene: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeListCell.identifier, for: indexPath) as? RecipeListCell else {
            return UITableViewCell()
        }
        let recipe = self.recipes[indexPath.row]
        cell.configureCell(model: recipe)
        cell.didTapCell = {
            // Dar o push para tela de descrição da receita
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
}

extension RecipeListScene: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearch = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Atualizar a table conforme o input do usuário
    }
}
