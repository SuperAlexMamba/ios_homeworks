//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Слава Орлов on 23.01.2023.
//

import Foundation
import UIKit
import StorageService

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
        
    var userPhoto: UIImageView = {
        
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        
        image.layer.shadowOffset = CGSize(width: 4, height: 4)
        image.layer.shadowRadius = 8
        image.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        image.layer.shadowOpacity = 1
        
        image.layer.cornerRadius = 38
        image.layer.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
        image.layer.borderWidth = 3
            
        image.clipsToBounds = true

        return image
    }()
    
    var stackView: UIStackView = {
        
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 20
        
        return view
    }()
    
    var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        label.numberOfLines = 2
        return label
    }()
    
    var userLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        return label
    }()
    
    var descriptionText: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .systemFont(ofSize: 14, weight: .medium)
        text.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
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
        text.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        return text
    }()
    
    var viewsLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .systemFont(ofSize: 16, weight: .medium)
        text.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        return text
    }()
        
    func setupCell(){
        
        self.addSubview(contentView)
        self.contentView.addSubview(postImage)
        self.contentView.addSubview(viewsLabel)
        self.contentView.addSubview(likesLabel)
        self.contentView.addSubview(descriptionText)
        self.contentView.addSubview(userPhoto)
        self.contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(userLabel)
        stackView.addArrangedSubview(authorLabel)

        setupConstraints()
        
        func setupConstraints(){
            let safeArea = contentView.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                
                postImage.topAnchor.constraint(equalTo: userPhoto.bottomAnchor, constant: 0),
                postImage.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0),
                postImage.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0),
                postImage.heightAnchor.constraint(equalToConstant: 200),
                
                descriptionText.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 10),
                descriptionText.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16),
                descriptionText.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 16),
                
                likesLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16),
                likesLabel.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 16),
                likesLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16),
                likesLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 10),
                
                viewsLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -16),
                viewsLabel.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 16),
                viewsLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16),
                viewsLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20),
                
                userPhoto.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 10),
                userPhoto.widthAnchor.constraint(equalToConstant: 75),
                userPhoto.heightAnchor.constraint(equalToConstant: 75),
                userPhoto.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 5),
                
                stackView.leftAnchor.constraint(equalTo: userPhoto.rightAnchor, constant: 5),
                stackView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0),
                stackView.bottomAnchor.constraint(equalTo: postImage.topAnchor),
                stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),

            ])
        }
    }
}
