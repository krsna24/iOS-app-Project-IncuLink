//
//  HeaderCollectionReusableView.swift
//  IncuLink
//
//  Created by Krsna College on 28/05/24.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    let headerLabel = UILabel()
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupHeader()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHeader()
    }
    
    private func setupHeader() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(headerLabel)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 300),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
