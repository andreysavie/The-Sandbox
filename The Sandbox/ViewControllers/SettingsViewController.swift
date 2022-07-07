//
//  SettingsViewController.swift
//  The Sandbox
//
//  Created by Андрей Рыбалкин on 06.07.2022.
//

import UIKit


class SettingsViewController: UIViewController {
        
    // MARK: PROPERTIES =========================================================================
    private lazy var settingsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    // MARK: INITS =========================================================================

    override func viewDidLoad() {
        super.viewDidLoad()
            
        settingsTableView.register(
            SortingTableViewCell.self,
            forCellReuseIdentifier: SortingTableViewCell.identifire
        )
        
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        setupLayout()
    }
    
    // MARK: METHODS =========================================================================

    private func setupLayout() {
        
        self.view.addSubview(settingsTableView)

        NSLayoutConstraint.activate([
            settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
}

// MARK: EXTENSIONS =========================================================================

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SortingTableViewCell.identifire, for: indexPath) as? SortingTableViewCell else { return UITableViewCell() }
            return cell
        default:
            let cell = UITableViewCell (style: .default, reuseIdentifier: nil)
            var content: UIListContentConfiguration = cell.defaultContentConfiguration()
            content.text = "Change user password"
            cell.contentConfiguration = content
            return cell
        }
    }
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let coordinator = Coordinator()
            coordinator.showDetail(state: .editPass, navCon: self.navigationController)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}
