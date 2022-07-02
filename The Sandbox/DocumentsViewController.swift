//
//  ViewController.swift
//  The Sandbox
//
//  Created by Андрей Рыбалкин on 02.07.2022.
//

import UIKit

class DocumentsViewController: UIViewController {
    
    var files = [Document]()

    
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
        addFilesToLibrary(Model.shared.images)
        getLabraryData()
  
    }
    
    func getLabraryData() {
        
        self.files.removeAll()
        
        let manager = FileManager.default
        guard
            let docUrl = try? manager.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            ),
            let contents = try? FileManager.default.contentsOfDirectory(at: docUrl,
                                                                        includingPropertiesForKeys: nil,
                                                                        options: [.skipsHiddenFiles])
        else { return }

        var attributes = [FileAttributeKey : Any]()

        for file in contents {
            let filePath = file.path
            
            do {
                attributes = try FileManager.default.attributesOfItem(atPath: filePath)
                
            } catch let error {
                print (error)
            }
            let creationDate = attributes[.creationDate]
            let fileSize = attributes[.size]
            let image = UIImage(contentsOfFile: filePath)
            
            files.append(Document(
                image: image ?? UIImage(),
                creationDate: String(describing: creationDate!),
                size: String(describing: fileSize!),
                filePath: filePath)
            )

        }
    }
    
    private func addFilesToLibrary(_ array: [String]) {
        let manager = FileManager.default
        
        guard let docUrl = try? manager.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            ) else { return }
        
        for fileItem in array {
            let imagePath = docUrl.appendingPathComponent(fileItem)
            let image = UIImage(named: fileItem) ?? UIImage()
            let data = image.jpegData(compressionQuality: 1.0)
           
            manager.createFile(atPath: imagePath.path, contents: data)
        }
        
    }
    
    private func removeFileFromLibrary (_ filePath: String) {
        do {
            try FileManager.default.removeItem(atPath: filePath)
        } catch {
            print(error)
        }
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
        return files.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DocumentsTableViewCell.identifire, for: indexPath) as? DocumentsTableViewCell else { return UITableViewCell() }
        cell.configureOfCell(document: files[indexPath.row])
        return cell
    }
    
}

extension DocumentsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeFileFromLibrary(files[indexPath.row].filePath)
            getLabraryData()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
}
