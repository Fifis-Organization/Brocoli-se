//
//  AlbumScene.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 20/09/21.
//

import UIKit
import Foundation

class AlbumScene: UIView {
    private var controller: AlbumViewController?
    private let stickers = [
        [StickersNames.esquiloBlank, StickersNames.esquiloSticker],
        [StickersNames.patinhoBlank, StickersNames.patinhoSticker],
        [StickersNames.pintinhoBlank, StickersNames.pintinhoSticker],
        [StickersNames.vaquinhaBlank, StickersNames.vaquinhaSticker],
        [StickersNames.jacarezinhoBlank, StickersNames.jacarezinhoSticker],
        [StickersNames.ovelhinhaBlank, StickersNames.ovelhinhaSticker],
        [StickersNames.porquinhoBlank, StickersNames.porquinhoSticker],
        [StickersNames.sapinhoBlank, StickersNames.sapinhoSticker],
        [StickersNames.zebrinhaBlank, StickersNames.zebrinhaSticker]
    ]
    private var point: Int = 0
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.isScrollEnabled = true
        
        return collectionView
    }()

    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()

        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.isUserInteractionEnabled = false

        return pageControl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blueDark
        
        setupCollectionView()
        setupPageControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPageControl() {
        addSubview(pageControl)

        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func isStickerAble(indexSticker: Int) -> Int {
        switch indexSticker {
        case 0:
            return self.point >= 100 ? 1 : 0
        case 1:
            return self.point >= 200 ? 1 : 0
        case 2:
            return self.point >= 300 ? 1 : 0
        case 3:
            return self.point >= 400 ? 1 : 0
        case 4:
            return self.point >= 500 ? 1 : 0
        case 5:
            return self.point >= 600 ? 1 : 0
        case 6:
            return self.point >= 700 ? 1 : 0
        case 7:
            return self.point >= 800 ? 1 : 0
        case 8:
            return self.point >= 900 ? 1 : 0
        case 9:
            return self.point >= 1000 ? 1 : 0
        default:
            return 0
        }
    }
}

extension AlbumScene: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }

        var pageStickers: [String] = []

        switch indexPath.item {
        case 0:
            for index in 0...3 {
                pageStickers.append(stickers[index][isStickerAble(indexSticker: index)])
            }
        case 1:
            for index in 4...7 {
                pageStickers.append(stickers[index][isStickerAble(indexSticker: index)])
            }
        case 2:
            pageStickers.append(stickers[8][isStickerAble(indexSticker: 8)])
        default:
            pageStickers.append("")
        }

        cell.setStickers(stickers: pageStickers)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.item
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

extension AlbumScene: AlbumSceneDelegate {
    func reloadCollection() {
        self.controller?.fetchUser()
        self.collectionView.reloadData()
    }
    
    func setController(controller: AlbumViewController) {
        self.controller = controller
    }
    
    func setUser(user: User?) {
        if let point = user?.point {
            self.point = Int(point)
        }
    }
    
    func setupDatas() {
        self.controller?.fetchUser()
    }
}
