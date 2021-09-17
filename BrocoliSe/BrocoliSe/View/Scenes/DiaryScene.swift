//
//  Scenes.swift
//  BrocoliSe
//
//  Created by Samuel Sales on 08/09/21.
//
import Foundation
import FOCalendar

class DiaryScene: UIView {
    let diaryCardComponent = DiaryCardComponent()
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
    
    func hierarchyView() {
        addSubview(diaryCardComponent)
        addSubview(diaryTableView)
    }
    
    func setupConstraints() {
        diaryCardComponentSetupConstraints()
        diaryTableViewSetupConstraints()
    }
    
    func diaryCardComponentSetupConstraints() {
        diaryCardComponent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            diaryCardComponent.topAnchor.constraint(equalTo: topAnchor),
            diaryCardComponent.leadingAnchor.constraint(equalTo: leadingAnchor),
            diaryCardComponent.trailingAnchor.constraint(equalTo: trailingAnchor),
            diaryCardComponent.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.55)
        ])
    }
    
    func diaryTableViewSetupConstraints() {
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
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DiaryTableViewCellComponent.reuseIdentifier, for: indexPath) as? DiaryTableViewCellComponent

        switch indexPath.row {
        case 0:
            cell?.setData(iconName: IconNames.carne, foodName: FoodNames.carne)
        case 1:
            cell?.setData(iconName: IconNames.ovos, foodName: FoodNames.ovos)
        case 2:
            cell?.setData(iconName: IconNames.leite, foodName: FoodNames.leite)
        case 3:
            cell?.setData(iconName: IconNames.frango, foodName: FoodNames.frango)
        case 4:
            cell?.setData(iconName: IconNames.peixe, foodName: FoodNames.peixe)
        default:
            cell?.setData(iconName: IconNames.carne, foodName: FoodNames.carne)
        }

        cell?.checkButtonCallBack = {
            // MARK: Teoricamente pega os dados da célula clicada pra salvar no CoreData aqui
            cell?.getData()
        }

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
