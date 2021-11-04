//
//  PerfilScene.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 21/10/21.
//

import UIKit

protocol SettingsSceneDelegate: AnyObject {
    func setController(controller: SettingsViewController)
    func setUser(user: User?)
    func setupData()
    func reloadTable()
}

class SettingsScene: UIView {
    private var controller: SettingsViewController?
    private var profileModel: ProfileModel?
    private let persistentService = PersistenceService()
    
    private let items = [
        ["Vibrações","vibracoes-icon"],
        ["Brocoli-se no Instagram", "instagram-icon"]
    ]
    
    private lazy var tableView: UITableView = {
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
    
    private func setupTableView() {
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
            if let profileModel = profileModel {
                cell.setupProfile(model: profileModel)
            }
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.identifier) as? SettingsCell else {
                return UITableViewCell()
            }
            
            var udKey: UserDefaultsKeys?
            
            if indexPath.row == 0 {
                udKey = .vibrations
            }

            cell.setSettingsLabel(text: items[indexPath.row][0])
            cell.setIconImageView(imageName: items[indexPath.row][1])
            
            if let udKey = udKey {
                cell.initSwitchStatus(value: persistentService.getKeyValue(udKey: udKey))
                cell.didSwitchButton = { (_ value: Bool) -> Void in
                    self.persistentService.persist(udKey: udKey, value: value)
                }
            }
            
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
        tableView.deselectRow(at: indexPath, animated: false)
        switch indexPath.section {
        case 0:
            self.controller?.settingsCoodinator?.showProfileViewController()
        case 1:
            if indexPath.row == 1 {
                let application = UIApplication.shared
                let username =  "brocoli.se"
                if let appURL = URL(string: "instagram://user?username=\(username)") {
                    if application.canOpenURL(appURL) {
                        application.open(appURL)
                    } else {
                        if let webURL = URL(string: "https://instagram.com/\(username)") {
                            application.open(webURL)
                        }
                    }
                }
            }
        default:
            return
        }
    }
}

extension SettingsScene: SettingsSceneDelegate {
    func setupData() {
        self.controller?.fetchUser()
    }
    
    func setUser(user: User?) {
        guard let name = user?.name else { return }
        self.profileModel = ProfileModel(name: name, icon: user?.icon)
    }
    
    func setController(controller: SettingsViewController) {
        self.controller = controller
    }
    
    func reloadTable() {
        self.tableView.reloadData()
    }
}
