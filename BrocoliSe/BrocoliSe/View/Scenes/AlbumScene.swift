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
        return collectionView
    }()

    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()

        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false

        return pageControl
    }()

    let btnNext: UIButton = {
        let button = UIButton(type: .system)

        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleNextPage), for: .touchUpInside)
        button.tag = 1

        return button
    }()

    let btnPrev: UIButton = {
        let button = UIButton(type: .system)

        button.setTitle("PREV", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleNextPage), for: .touchUpInside)
        button.tag = 0

        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blueDark
        
        setupCollectionView()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        [btnNext, btnPrev, pageControl].forEach {
            self.addSubview($0) }

        btnNext.heightAnchor.constraint(equalToConstant: 48).isActive = true
        btnNext.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -32).isActive = true
        btnNext.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true

        btnPrev.heightAnchor.constraint(equalToConstant: 48).isActive = true
        btnPrev.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32).isActive = true
        btnPrev.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true

        pageControl.centerYAnchor.constraint(equalTo: btnNext.centerYAnchor).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }

    @objc func handleNextPage(button: UIButton) {
        var indexPath: IndexPath!
        var current = pageControl.currentPage
        print(">>>>>>>>>>ENTREI")
        if button.tag == 0 {
            current -= 1
            if current < 0 {
                current = 0
            }
        } else {
            current += 1
            if current > 2 {
                current = 0
            }
        }
        print(current)
        indexPath = IndexPath(item: current, section: 0)
        print(indexPath)

        self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
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
        cell.setImage(image: UIImage(named: stickers[indexPath.item][isStickerAble(indexSticker: indexPath.item)]))
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: self.frame.width, height: self.frame.height)
    }

}

extension AlbumScene: AlbumSceneDelegate {
    func selectPage(page: Int) {
        self.pageControl.currentPage = page
    }

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
