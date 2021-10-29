//
//  PerfilScene.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 21/10/21.
//

import UIKit

protocol SettingsSceneDelegate: AnyObject {
    func setController(controller: SettingsViewController)
}

class SettingsScene: UIView {
    private var controller: SettingsViewController?
    let items = [
        ["Vibrações","vibracoes-icon"],
        ["Notificações", "notificacoes-icon"],
        ["Brocoli-se no Instagram", "instagram-icon"]
    ]
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.allowsSelection = true
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.identifier)
        table.register(ProfileSelectionCell.self, forCellReuseIdentifier: ProfileSelectionCell.identifier)
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(tableView)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
}

extension SettingsScene: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return items.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSelectionCell.identifier) as? ProfileSelectionCell else {
                return UITableViewCell()
            }
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.identifier) as? SettingsCell else {
                return UITableViewCell()
            }
            cell.setSettingsLabel(text: items[indexPath.row][0])
            cell.setIconImageView(imageName: items[indexPath.row][1])
            
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textColor = UIColor.blueDark
        label.font = UIFont.graviolaSoft(size: 20)
        
        switch section {
        case 0:
            label.text = "  Perfil"
        case 1:
            label.text = "  Ajustes"
        default:
            label.text = ""
        }
        
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            self.controller?.settingsCoodinator?.showProfileViewController()
            tableView.deselectRow(at: indexPath, animated: false)
        default:
            return
        }
    }
}

extension SettingsScene: SettingsSceneDelegate {
    func setController(controller: SettingsViewController) {
        self.controller = controller
    }
}
