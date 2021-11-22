//
//  RecipeListScene.swift
//  BrocoliSe
//
//  Created by Larissa Uchoa on 09/11/21.
//

import UIKit

enum ViewState {
    case load
    case error
    case content(models: [RecipeModel])
}

struct RecipeCellModel {
    var idRecipe, name, portions, time: String
    var ingredients, steps: [String]
    var pathPhoto: UIImage?
    var pathPhotoString: String
}

class RecipeListScene: UIView {

    private var controller: RecipeListViewController?
    private var isSearch: Bool = false
    private var isActiveKeyboard: Bool = false
    private var recipes: [RecipeCellModel] = [] {
        didSet {
            self.filteredData = recipes
        }
    }
    private var filteredData: [RecipeCellModel] = [] {
        didSet {
            self.filteredData = filteredData.sorted(by: { $1.name > $0.name})
            self.reloadTable()
        }
    }
    
    private var recipesCoredata: [RecipeCellModel] = [] {
        didSet {
            self.filteredData = recipesCoredata
        }
    }

    private lazy var segmentedControl: CustomSegmentedControl = {
        let segmentedControl = CustomSegmentedControl()
        segmentedControl.backgroundColor = .clear
        segmentedControl.indexChanged(newIndex: 0)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        return segmentedControl
    }()

    private lazy var recipesTableView: UITableView = {
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
    
    private var spinner = UIActivityIndicatorView(style: .large)

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
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        segmentedControl.indexChanged(newIndex: sender.selectedSegmentIndex)
        if sender.selectedSegmentIndex == 1 {
            if spinner.isAnimating {
                spinner.stopAnimating()
            }
            let coredataManager = CoreDataManager(dataModelType: .recipe)
            var recipesHelp: [RecipeCellModel] = []
            let recipesFetch: [Recipe] = coredataManager.fetch()
            recipesFetch.forEach {
                if let idRecipe = $0.id,
                   let name = $0.nome,
                   let portions = $0.porcoes,
                   let time = $0.tempo,
                   let setIngredients = $0.ingredients as? Set<Ingredient>,
                   let setSteps = $0.steps as? Set<Steps>,
                   let pathPhotoString = $0.pathFotoString {
                    var ingredients: [String] = []
                    var steps: [String] = []
                    setIngredients.forEach { ingredients.append($0.ingredient ?? "") }
                    setSteps.forEach { steps.append($0.step ?? "") }
                    recipesHelp.append(RecipeCellModel(idRecipe: idRecipe,
                                                       name: name,
                                                       portions: portions,
                                                       time: time,
                                                       ingredients: Array(ingredients),
                                                       steps: Array(steps),
                                                       pathPhoto: UIImage(data: $0.pathFoto ?? Data()),
                                                       pathPhotoString: pathPhotoString))
                } 
            }
            self.recipesCoredata = recipesHelp
            recipesTableView.restore()
            if recipesHelp.isEmpty {
                self.recipesTableView.setEmptyView(for: .savedRecipes)
            }
        } else {
            recipesTableView.restore()
            if self.recipes.isEmpty {
                self.recipesTableView.setEmptyView(for: .apiRecipes)
            }
            self.filteredData = recipes
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
        whiteView.addSubview(spinner)
        whiteView.addSubview(recipesTableView)
        whiteView.addSubview(segmentedControl)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            whiteView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 30),
            whiteView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            whiteView.leftAnchor.constraint(equalTo: self.leftAnchor),
            whiteView.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 20),
            segmentedControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalToConstant: 220),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30),

            recipesTableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 30),
            recipesTableView.bottomAnchor.constraint(equalTo:whiteView.bottomAnchor),
            recipesTableView.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor),
            recipesTableView.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor),
            
            spinner.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 30),
            spinner.centerYAnchor.constraint(equalTo: whiteView.centerYAnchor),
            spinner.bottomAnchor.constraint(equalTo:whiteView.bottomAnchor),
            spinner.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor),
            spinner.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor)
        ])
    }
    
    private func tapButtonGesture() -> UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(didTapReloadButton))
    }
    
    @objc private func didTapReloadButton() {
        controller?.fetchRecipesApi()
    }
    
}

extension RecipeListScene: RecipeListSceneDelegate {
    func setupViewState(from viewState: ViewState) {
        switch viewState {
        case .load:
            self.spinner.startAnimating()
        case .error:
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                self.recipesTableView.restore()
                self.recipesTableView.setEmptyView(for: .apiRecipes, tapButton: self.tapButtonGesture())
            }
        case .content(let models):
            DispatchQueue.main.async {
                self.recipesTableView.restore()
                if self.spinner.isAnimating {
                    self.spinner.stopAnimating()
                }
            }
            var recipesHelp: [RecipeCellModel] = []
            models.forEach {
                recipesHelp.append(RecipeCellModel(idRecipe: $0.id,
                                                   name: $0.name,
                                                   portions: $0.portions,
                                                   time: $0.time,
                                                   ingredients: $0.ingredients,
                                                   steps: $0.steps,
                                                   pathPhoto: nil,
                                                   pathPhotoString: $0.pathPhoto))
            }
            self.recipes = recipesHelp
        }
    }
    
    func setupSiriResearch(recipe: String) {
        searchBar.searchTextField.text = recipe
        segmentedControl.indexChanged(newIndex: 0)
        filteredData = recipe.isEmpty ? recipes : recipes.filter {
            $0.name.range(of: recipe, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        self.recipesTableView.restore()
        if filteredData.isEmpty {
            self.recipesTableView.setEmptyView(for: .emptySearch)
        }
        reloadTable()
    }
    
    func setController(controller: RecipeListViewController) {
        self.controller = controller
    }

    func reloadTable() {
        DispatchQueue.main.async {
            self.recipesTableView.reloadData()
        }
    }
}

extension RecipeListScene: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeListCell.identifier, for: indexPath) as? RecipeListCell else {
            return UITableViewCell()
        }
        let recipe = self.filteredData[indexPath.row]
        cell.configureCell(model: recipe)
        cell.didTapCell = {
            self.controller?.tabCoordinator?.showRecipeCoordinator(recipe: recipe)
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
        if self.segmentedControl.selectedSegmentIndex == 1 {
            filteredData = searchText.isEmpty ? recipesCoredata : recipesCoredata.filter {
                $0.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
        } else {
            filteredData = searchText.isEmpty ? recipes : recipes.filter {
                $0.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
        }
        self.recipesTableView.restore()
        if filteredData.isEmpty {
            self.recipesTableView.setEmptyView(for: .emptySearch)
        }
        reloadTable()
    }
}
