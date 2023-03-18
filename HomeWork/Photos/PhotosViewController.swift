//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Слава Орлов on 30.01.2023.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, ImageLibrarySubscriber {
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.addSubview(navBar)
    }
    
    var imagePublisherFacade = ImagePublisherFacade()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        view.backgroundColor = .white
        view.addSubview(collectionView)
                
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupConstraints()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navBar.isHidden = true
    }
    
    lazy var navBar: UINavigationBar = {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: self.view.frame.size.width, height: 44))
        let navigationItem = UINavigationItem(title: "Photos Gallery")
        let navigationButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: #selector(backButton))
        navigationItem.leftBarButtonItems = [navigationButton]
        navBar.setItems([navigationItem], animated: true)
        
        return navBar
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")        
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        return collection
        }()
    
    private func setupConstraints(){

        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
    
    @objc func backButton(){
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
        imagePublisherFacade.removeSubscription(for: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotosCollectionViewCell
        let data = photosArray
        let item = data[indexPath.row]
                
        cell.photosImage.image = item.image
        
        receive(images: [item.image])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let photos = photosArray.count
        return photos
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 18)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let wight = 115
        let heigh = 115
        
        return CGSize(width: wight, height: heigh)
    }
        
}

extension PhotosViewController {
    
    func receive(images: [UIImage]) {
        
        imagePublisherFacade.subscribe(self)
        imagePublisherFacade.addImagesWithTimer(time: 0.5, repeat: 20)
        
    }

}
