//
//  DocumentsTableViewCell.swift
//  The Sandbox
//
//  Created by Андрей Рыбалкин on 02.07.2022.
//

import UIKit

class DocumentsTableViewCell: UITableViewCell {
    
    static let identifire = "PostTableViewCell"
    
    // MARK: PROPERTIES =================================================

    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var fileCreationDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var fileSize: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()

    // MARK: INITS =====================================================

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(image)
        contentView.addSubview(fileCreationDate)
        contentView.addSubview(fileSize)
        
        setupLayout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureOfCell(document: Document) {
        self.image.image = document.image
        self.fileCreationDate.text = Date.getFormattedDate(string: document.creationDate)
        self.fileSize.text = "file size: \(document.size) bytes" 
    }
    
    // MARK: LAYOUT =====================================================

    private func setupLayout() {
        
        NSLayoutConstraint.activate([
        
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            image.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.25),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
            
            fileCreationDate.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            fileCreationDate.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            fileCreationDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            fileSize.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            fileSize.topAnchor.constraint(equalTo: fileCreationDate.bottomAnchor, constant: 8),
            fileSize.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}

extension Date {
    static func getFormattedDate(string: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "E, d MMM yyyy HH:mm:ss"
        dateFormatterPrint.timeZone = TimeZone.current

        let date: Date? = dateFormatterGet.date(from: string)
        print("Date",dateFormatterPrint.string(from: date!))
        return dateFormatterPrint.string(from: date!);
    }
}
