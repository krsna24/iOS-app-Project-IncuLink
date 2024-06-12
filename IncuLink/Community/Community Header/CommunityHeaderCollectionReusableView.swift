//
//  CommunityHeaderCollectionReusableView.swift
//  IncuLink
//
//  Created by Ankit Rajput on 29/05/24.
//

import UIKit

class CommunityHeaderCollectionReusableView: UICollectionReusableView {
    let communityHeaderLabel = UILabel()
    let communityButton: UIButton = {
        let communityButton1 = UIButton(type: .system)
        communityButton1.translatesAutoresizingMaskIntoConstraints = false
        return communityButton1
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupCommunityHeader()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCommunityHeader()
    }
    
    private func setupCommunityHeader() {
        communityHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(communityHeaderLabel)
        addSubview(communityButton)
        
        NSLayoutConstraint.activate([
            communityHeaderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            communityHeaderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            communityHeaderLabel.topAnchor.constraint(equalTo: self.topAnchor),
            communityHeaderLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            communityButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 300),
            communityButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            communityButton.topAnchor.constraint(equalTo: self.topAnchor),
            communityButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
