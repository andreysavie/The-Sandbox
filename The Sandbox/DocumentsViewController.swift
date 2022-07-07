//
//  ViewController.swift
//  The Sandbox
//
//  Created by Андрей Рыбалкин on 02.07.2022.
//

import UIKit

class DocumentsViewController: UIViewController, UINavigationControllerDelegate {
    
    
    // MARK: PROPERTIES =================================================
        
    private var files = [Document]()
    
    private lazy var documentsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private lazy var barButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem (
            title: "Add photo",
            style: .plain,
            target: self,
            action: #selector(barButtonAction)
        )
        button.tintColor = .brown
        return button
    }()
    
    private lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.mediaTypes = ["public.image"]
        picker.sourceType = .photoLibrary
        return picker
    }()
  
    // MARK: INITS =====================================================

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem  = barButtonItem
        self.view.addSubview(documentsTableView)
        
        documentsTableView.register(
            DocumentsTableViewCell.self,
            forCellReuseIdentifier: DocumentsTableViewCell.identifire
        )
        
        documentsTableView.dataSource = self
        documentsTableView.delegate = self
        imagePicker.delegate = self

        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getLibraryData()
    }
    
    // MARK: METHODS =====================================================
    
    func getLibraryData() {

        files.removeAll()
        
        let manager = FileManager.default
        
        guard
            let docUrl = try? manager.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false),
            
            let contents = try? FileManager.default.contentsOfDirectory(
                at: docUrl,
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
            
            let fileName = (filePath as NSString).lastPathComponent
            let creationDate = attributes[.creationDate]
            let image = UIImage(contentsOfFile: filePath)
            
            let data = Document(
                image: image ?? UIImage(),
                creationDate: String(describing: creationDate!),
                name: fileName,
                filePath: filePath
            )
            
            files.append(data)
            

        }
        if UserDefaults.standard.bool(forKey: "switcher") {
            files.sort(by: { $1.name > $0.name } )
        } else {
            files.sort(by: { $0.name > $1.name } )
        }
        
        documentsTableView.reloadData()
        
    }
    
    private func addPhotoToLibrary(_ photo: UIImage) {
        let manager = FileManager.default
        
        guard let docUrl = try? manager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ) else { return }
        
        let fileItem = UUID().uuidString
        let imagePath = docUrl.appendingPathComponent("\(fileItem).jpg")
        let data = photo.jpegData(compressionQuality: 1.0)
        
        manager.createFile(atPath: imagePath.path, contents: data)
        
        getLibraryData()
    }
    
    private func removeFileFromLibrary (_ filePath: String) {
        do {
            try FileManager.default.removeItem(atPath: filePath)
        } catch {
            print(error)
        }
    }

    // MARK: LAYOUT =====================================================

    private func setupLayout() {
        NSLayoutConstraint.activate([
            documentsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            documentsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            documentsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            documentsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: OBJC - METHODS =====================================================

    @objc
    private func barButtonAction() {
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: EXTENSIONS =====================================================


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
            self.files.remove(at: indexPath.row)
            self.documentsTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My documents"
    }
    
}

extension DocumentsViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { return }
        self.addPhotoToLibrary(image)
        self.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


extension UIViewController {
    
    func toAutolayout(_ views: UIView ...) {
        views.forEach( { $0.translatesAutoresizingMaskIntoConstraints = false } )
    }
}




