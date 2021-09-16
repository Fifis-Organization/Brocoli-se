//
//  ViewController.swift
//  BrocoliSe
//
//  Created by Samuel Sales on 08/09/21.
//

import UIKit

class ViewController: UIViewController {

    let progress = ProgressBarComponent()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(progress)
        self.view.addSubview(tableView)

        configureProgress()
        configureTable()

        view.backgroundColor = UIColor.blueDark
        title = "Poc"

    }

    func configureProgress() {
        progress.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            progress.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            progress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            progress.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    func configureTable() {
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(DiaryTableViewCellComponent.self, forCellReuseIdentifier: "foodCell")

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: progress.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as? DiaryTableViewCellComponent

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
