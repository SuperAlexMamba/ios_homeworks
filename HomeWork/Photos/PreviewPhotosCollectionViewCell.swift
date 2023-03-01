//
//  PreviewPhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Слава Орлов on 28.01.2023.
//

import UIKit

class PreviewPhotosCollectionViewCell: UICollectionViewCell {
    
    lazy var photosImage: UIImageView = {
        let image = UIImageView()
        
        image.translatesAutoresizingMaskIntoConstraints = false

        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(contentView)
        contentView.addSubview(photosImage)
        
        setupConstraints()
        
    }
    
    private func setupConstraints(){
        
        let safeArea = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
        
            photosImage.topAnchor.constraint(equalTo: safeArea.topAnchor),
            photosImage.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            photosImage.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            photosImage.rightAnchor.constraint(equalTo: safeArea.rightAnchor)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
