//
//  DocumentsTableViewCell.swift
//  The Sandbox
//
//  Created by Андрей Рыбалкин on 02.07.2022.
//

import UIKit

class DocumentsTableViewCell: UITableViewCell {
    
    static let identifire = "PostTableViewCell"


    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var imageName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var imageDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(image)
        contentView.addSubview(imageName)
        contentView.addSubview(imageDescription)
        
        setupLayout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureOfCell(document: Document) {
        self.image.image = UIImage(named: document.image)
        self.imageName.text = document.name
        self.imageDescription.text = document.description
    }
    
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
        
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            image.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.25),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
            
            imageName.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            imageName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            imageDescription.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            imageDescription.topAnchor.constraint(equalTo: imageName.bottomAnchor, constant: 8),
            imageDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

        
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
