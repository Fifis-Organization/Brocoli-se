//
//  RecipeDescriptionScene.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 17/11/21.
//

import UIKit

class RecipeDescriptionScene: UIView {
    
    private var controller: RecipeDescriptionViewController?
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.allowsSelection = false
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.register(InforRecipeCell.self, forCellReuseIdentifier: InforRecipeCell.identifier)
        table.register(IngredientsCell.self, forCellReuseIdentifier: IngredientsCell.identifier)
        table.register(StepsCell.self, forCellReuseIdentifier: StepsCell.identifier)
        table.estimatedRowHeight = 85
        return table
    }()
    
    private var recipe: RecipeModel?
    
    private let headerImage = HeaderImageView()
    
    private var numberOfSteps = 3
    private var step = 0
    
    private let whiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        view.layer.cornerRadius  = 20
        return view
    }()
    
    init(frame: CGRect, recipe: RecipeModel) {
        super.init(frame: frame)
        self.recipe = recipe
        self.numberOfSteps = self.recipe?.steps.count ?? 0
        configHeaderImageView()
        setupWhiteView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupWhiteView() {
        addSubview(whiteView)
        whiteView.addSubview(tableView)

        NSLayoutConstraint.activate([
            whiteView.topAnchor.constraint(equalTo: headerImage.bottomAnchor, constant: -20),
            whiteView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            whiteView.leftAnchor.constraint(equalTo: self.leftAnchor),
            whiteView.rightAnchor.constraint(equalTo: self.rightAnchor),

            tableView.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 25),
            tableView.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor)
         ])
    }
    
    private func configHeaderImageView() {
        self.addSubview(headerImage)
        headerImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerImage.topAnchor.constraint(equalTo: self.topAnchor),
            headerImage.leftAnchor.constraint(equalTo: self.leftAnchor),
            headerImage.rightAnchor.constraint(equalTo: self.rightAnchor),
            headerImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(UIScreen.main.bounds.height * 0.68))
        ])
        
        headerImage.setImageHeader(urlString: recipe?.pathPhoto ?? "")
    }
}

extension RecipeDescriptionScene: RecipeDescriptionSceneDelegate {
    
    func setController(controller: RecipeDescriptionViewController) {
        self.controller = controller
    }
}

extension RecipeDescriptionScene: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return recipe?.ingredients.count ?? 0
        case 2:
            return recipe?.steps.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textColor = UIColor.blueDark
        label.font = UIFont.graviolaSoft(size: 20)
        label.numberOfLines = 0
        
        switch section {
        case 0:
            label.font = UIFont.graviolaSoft(size: 22)
            guard let recipeName = recipe?.name else { return label }
            label.text = "  \(recipeName)"
        case 1:
            label.text = "   Ingredientes"
        case 2:
            label.text = "   Modo de Preparo"
        default:
            label.text = ""
        }
        
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InforRecipeCell.identifier, for: indexPath) as? InforRecipeCell else {
                return UITableViewCell()
            }
            cell.setCardInfo(timerText: recipe?.time.uppercased() ?? "", porcoesText: recipe?.portions.uppercased() ?? "")
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsCell.identifier, for: indexPath) as? IngredientsCell else {
                return UITableViewCell()
            }
            cell.setIngredientsLabel(text: recipe?.ingredients[indexPath.row] ?? "")
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StepsCell.identifier, for: indexPath) as? StepsCell else {
                return UITableViewCell()
            }
            if step != numberOfSteps {
                step += 1
                cell.setStep(number: self.step, text: recipe?.steps[indexPath.row] ?? "")
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        default:
            return UITableView.automaticDimension
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
}
