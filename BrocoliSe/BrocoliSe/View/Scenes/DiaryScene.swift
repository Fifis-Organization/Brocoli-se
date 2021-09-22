//
//  Scenes.swift
//  BrocoliSe
//
//  Created by Samuel Sales on 08/09/21.
//
import Foundation
import FOCalendar

class DiaryScene: UIView {
    
    private var controller: DiaryViewController?
    private var foods: [FoodOff]? {
        didSet {
            diaryTableView.reloadData()
        }
    }
    
    private let diaryCardComponent = DiaryCardComponent()
    
    lazy var diaryTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.allowsSelection = false
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.register(DiaryTableViewCellComponent.self, forCellReuseIdentifier: DiaryTableViewCellComponent.reuseIdentifier)
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.backgroundColor
        hierarchyView()
        setupConstraints()
    }
    
    private func hierarchyView() {
        addSubview(diaryCardComponent)
        addSubview(diaryTableView)
    }
    
    private func setupConstraints() {
        diaryCardComponentSetupConstraints()
        diaryTableViewSetupConstraints()
    }
    
    private func diaryCardComponentSetupConstraints() {
        diaryCardComponent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            diaryCardComponent.topAnchor.constraint(equalTo: topAnchor),
            diaryCardComponent.leadingAnchor.constraint(equalTo: leadingAnchor),
            diaryCardComponent.trailingAnchor.constraint(equalTo: trailingAnchor),
            diaryCardComponent.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.55)
        ])
    }
    
    private func diaryTableViewSetupConstraints() {
        NSLayoutConstraint.activate([
            diaryTableView.topAnchor.constraint(equalTo: diaryCardComponent.bottomAnchor),
            diaryTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            diaryTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            diaryTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DiaryScene: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryTableViewCellComponent.reuseIdentifier, for: indexPath) as? DiaryTableViewCellComponent,
              let food = foods?[indexPath.row] else { fatalError() }

        let foodName = food.food ?? ""
        cell.setData(iconName: foodName.iconTable(), foodName:  foodName)
        cell.checkButtonCallBack = {
            // MARK: Teoricamente pega os dados da célula clicada pra salvar no CoreData aqui
            cell.getData()
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension DiaryScene: DiarySceneDelegate {
    func setDayAll(days: [Day]) {
        
    }
    
    func setFoodAll(foods: [FoodOff]) {
        self.foods = foods
    }
    
    func setController(controller: DiaryViewController) {
        self.controller = controller
    }
    
    func setUser(user: User?) {
        diaryCardComponent.setUser(user: user)
    }
    
    func setupDatas() {
        controller?.fetchFoodAll()
        controller?.fetchUser()
    }
}
