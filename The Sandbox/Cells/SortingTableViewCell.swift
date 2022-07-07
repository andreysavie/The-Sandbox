//
//  SortingTableViewCell.swift
//  The Sandbox
//
//  Created by Андрей Рыбалкин on 06.07.2022.
//

import UIKit

class SortingTableViewCell: UITableViewCell {
    
    static let identifire = "SortingTableViewCell"
    
    // MARK: PROPERTIES =================================================

    private lazy var switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.addTarget(self, action: #selector(saveSwitcherValue), for: .valueChanged)
        return switcher
    }()
    
    private lazy var sortingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sort alphabetically"
        return label
    }()
    


    // MARK: INITS =====================================================

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        switcher.isOn = UserDefaults.standard.bool(forKey: "switcher")

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: LAYOUT =====================================================

    private func setupLayout() {
        
        contentView.addSubview(switcher)
        contentView.addSubview(sortingLabel)
        
        NSLayoutConstraint.activate([
                    
            sortingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            sortingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            switcher.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            switcher.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
        ])
    }
    
    // MARK: METHODS =====================================================

    @objc
    func saveSwitcherValue() {
        UserDefaults.standard.setValue(switcher.isOn, forKey: "switcher")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
