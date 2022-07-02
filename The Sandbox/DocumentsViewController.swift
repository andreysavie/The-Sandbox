//
//  ViewController.swift
//  The Sandbox
//
//  Created by Андрей Рыбалкин on 02.07.2022.
//

import UIKit

class DocumentsViewController: UIViewController {

    
    private lazy var documentsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.view.addSubview(documentsTableView)
        
        documentsTableView.register(
            DocumentsTableViewCell.self,
            forCellReuseIdentifier: DocumentsTableViewCell.identifire
        )
        
        documentsTableView.dataSource = self
        documentsTableView.delegate = self

        setupLayout()
        
    }


    private func setupLayout() {
        NSLayoutConstraint.activate([
            documentsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            documentsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            documentsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            documentsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension DocumentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DocumentsTableViewCell.identifire, for: indexPath) as? DocumentsTableViewCell else { return UITableViewCell() }
        cell.configureOfCell(document: Model.shared.documents[indexPath.row])
        return cell
    }
    
    
}

extension DocumentsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
