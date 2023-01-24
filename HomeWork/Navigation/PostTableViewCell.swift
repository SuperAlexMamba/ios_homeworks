//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Слава Орлов on 23.01.2023.
//

import Foundation
import UIKit

class PostTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupCell()

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        isHidden = false
        isSelected = false
        isHighlighted = false
    }
    
    var authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.font = .systemFont(ofSize: 20, weight: .bold)
        authorLabel.textColor = .black
        authorLabel.numberOfLines = 2
        return authorLabel
    }()
    
    var descriptionText: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .systemFont(ofSize: 14, weight: .medium)
        text.textColor = .systemGray
        text.numberOfLines = 0
        return text
    }()
    
    var postImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        
        return image
    }()
    
    var likesLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .systemFont(ofSize: 16, weight: .medium)
        text.textColor = .black
        return text
    }()
    
    var viewsLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .systemFont(ofSize: 16, weight: .medium)
        text.textColor = .black
        return text
    }()
    
    func setupCell(){
        
        self.addSubview(contentView)
        
        self.contentView.addSubview(authorLabel)
        self.contentView.addSubview(postImage)
        self.contentView.addSubview(viewsLabel)
        self.contentView.addSubview(likesLabel)
        self.contentView.addSubview(descriptionText)
        
        setupConstraints()
        
        func setupConstraints(){
            let safeAreaGuide = contentView.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                
                authorLabel.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor, constant: 16),
                authorLabel.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor, constant: 16),
                authorLabel.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 16),
                authorLabel.heightAnchor.constraint(equalToConstant: 40),
                
                postImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 0),
                postImage.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor, constant: 0),
                postImage.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor, constant: 0),
                postImage.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
                
                descriptionText.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 10),
                descriptionText.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor, constant: 16),
                descriptionText.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor, constant: 16),
                
                likesLabel.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor, constant: 16),
                likesLabel.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 16),
                likesLabel.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: -16),
                likesLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 10),
                
                viewsLabel.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor, constant: -16),
                viewsLabel.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 16),
                viewsLabel.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: -16),
                viewsLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20)
                    
            ])
        }
    }
}
