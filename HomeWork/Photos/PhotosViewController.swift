//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Слава Орлов on 30.01.2023.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.addSubview(navBar)
        
    }
    
    let imageProcessor = ImageProcessor()
    var photosArray = PhotosArray.shared.photosArray
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        setupConstraints()
        
        DispatchQueue.main.async {
            self.processorImageOne()
            self.processorImageTwo()
            self.processorImageThree()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(8), execute: {
            self.collectionView.reloadData()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
    }
    
    func processorImageOne() {
        
        let start = DispatchTime.now()
        self.imageProcessor.processImagesOnThread(sourceImages: photosArray, filter: .sepia(intensity: 10), qos: .default) { image in
            
            for items in image {
                self.photosArray.append(UIImage(cgImage: items!))
            }
            let end = DispatchTime.now()
            let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
            let timeInterval = Double(nanoTime) / 1_000_000_000
            print("Time to processOne \(timeInterval)")
        }

    }
    
    func processorImageTwo() {
        
        let start = DispatchTime.now()
        self.imageProcessor.processImagesOnThread(sourceImages: photosArray, filter: .sepia(intensity: 10), qos: .background) { image in
            
            for items in image {
                self.photosArray.append(UIImage(cgImage: items!))
            }
            let end = DispatchTime.now()
            let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
            let timeInterval = Double(nanoTime) / 1_000_000_000
            print("Time to processTwo \(timeInterval)")
        }

    }
    
    func processorImageThree() {
        
        let start = DispatchTime.now()
        self.imageProcessor.processImagesOnThread(sourceImages: photosArray, filter: .sepia(intensity: 10), qos: .userInitiated) { image in
            
            for items in image {
                self.photosArray.append(UIImage(cgImage: items!))
            }
            let end = DispatchTime.now()
            let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
            let timeInterval = Double(nanoTime) / 1_000_000_000
            print("Time to processThree \(timeInterval)")
        }
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
        collection.reloadData()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        return collection
        }()
    
    private func setupConstraints() {

        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
    
    @objc func backButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotosCollectionViewCell
    
        let images = photosArray[indexPath.row]
                
        cell.photosImage.image = images
                
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

