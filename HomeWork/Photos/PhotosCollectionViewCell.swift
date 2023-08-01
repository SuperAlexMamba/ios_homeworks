//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Слава Орлов on 30.01.2023.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    
    lazy var photosImage: UIImageView = {
        let image = UIImageView()
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .systemGray4)
        
        self.addSubview(contentView)
        
        contentView.backgroundColor = self.backgroundColor
        
        contentView.addSubview(photosImage)
        
        setupConstraints()
        
    }
    
    private func setupConstraints(){
        
        let safeArea = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([

            photosImage.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            photosImage.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 8),
            photosImage.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 8),
            photosImage.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 8)
            
])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
