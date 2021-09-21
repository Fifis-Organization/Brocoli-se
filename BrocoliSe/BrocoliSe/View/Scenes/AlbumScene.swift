//
//  AlbumScene.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 20/09/21.
//

import UIKit
import Foundation

class AlbumScene: UIView {
    
    let stickers = [
        [StickersNames.esquiloBlank, StickersNames.esquiloSticker],
        [StickersNames.patinhoBlank, StickersNames.patinhoSticker],
        [StickersNames.pintinhoBlank, StickersNames.pintinhoSticker],
        [StickersNames.vaquinhaBlank, StickersNames.vaquinhaSticker]
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
        layout.itemSize = CGSize(width: (frame.width/2) - 80, height: 130)
            
            let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.isScrollEnabled = true
            collectionView.backgroundColor = .clear
            return collectionView
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blueDark
        
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        addSubview(collectionView)
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        
    }
}

extension AlbumScene: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.imageView.image = UIImage(named: stickers[indexPath.item][1])
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }

}
