//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Слава Орлов on 28.01.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var photosArray = PhotosArray.shared.photosArray
    
    var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "photos_title_key".localized
        label.textColor = .black
        
        return label
    }()
    
    var navigationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
    
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal
        collection.backgroundColor = .white
        collection.register(PreviewPhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCell")
        
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "PhotosCell")
        
        self.addSubview(contentView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupView()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        
        contentView.addSubview(collectionView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(navigationButton)
        
    }
    
    private func setupConstraints(){
        let safeArea = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            titleLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12),
            
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -12),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12),
            
            navigationButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12),
            navigationButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12),
            navigationButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            navigationButton.widthAnchor.constraint(equalToConstant: 30)
            
        ])
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as! PreviewPhotosCollectionViewCell
        
        let data = photosArray
        
        let item = data[indexPath.row]
        
        cell.photosImage.image = item
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = CGFloat(85)
        let height = CGFloat(70)

        return CGSize(width: width, height: height)
    }

}
