//
//  ViewController.swift
//  TZ1
//
//  Created by Даниил on 2024/01/14.
//

import UIKit

protocol ImageGalleryScreenViewProtocol: AnyObject {
    func reloadData()
    func setupImage(image: UIImage)
    func reloadDataAtSecondCollectionView()
}

class ImageGalleryScreenViewController: UIViewController, ImageGalleryScreenViewProtocol {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var secondCollectionView: UICollectionView!
    
    private let mainTile = "VKUSSOVET"
    private let fontName = "Impact"
    private let categoryCollectionViewCellID = "CategoryCollectionViewCell"
    private let secondCategoryCollectionViewCellID = "SecondCategoryCollectionViewCell"
    private let headerID = "HeaderID"
    let categoryCell = CategoryCollectionViewCell()
    let presenter = ImageGalleryScreenPresenter()
    lazy var collectionView1DelegateDataSource = CollectionView1DelegateDataSource(presenter: self.presenter)
    lazy var collectionView2DelegateDataSource = CollectionView2DelegateDataSource(presenter: self.presenter)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRightTopBar()
        setupCollectionViews()
        setupTopBar()
        presenter.attachView(view: self)
        presenter.makeFirstRequest()
    }
    
    func setupImage(image: UIImage) {
        categoryCell.setupImage(image: image)
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func reloadDataAtSecondCollectionView() {
        secondCollectionView.reloadData()
        secondCollectionView.reloadSections(IndexSet(integer: 0))
    }
    
    private func setupCollectionViews() {
        collectionView.backgroundColor = .clear
        collectionView.delegate = collectionView1DelegateDataSource
        collectionView.dataSource = collectionView1DelegateDataSource
        collectionView.register(UINib.init(nibName: categoryCollectionViewCellID, bundle: Bundle.main), forCellWithReuseIdentifier: categoryCollectionViewCellID)
        secondCollectionView.delegate = collectionView2DelegateDataSource
        secondCollectionView.dataSource = collectionView2DelegateDataSource
        secondCollectionView.register(UINib.init(nibName: secondCategoryCollectionViewCellID, bundle: Bundle.main), forCellWithReuseIdentifier: secondCategoryCollectionViewCellID)
        secondCollectionView.register(HeaderClass.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID)
    }
    
    private func setupTopBar() {
        let button = UIButton(type: .system)
        button.setTitle(mainTile, for: .normal)
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.titleLabel?.font = UIFont(name: fontName, size: 27)
        button.setTitleColor(.white, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2.5, right: 0)
        let barButtonItem = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    private func setupRightTopBar() {
        let systemImage = UIImage(systemName: "phone.circle")
        let button = UIButton(type: .system)
        button.setImage(systemImage, for: .normal)
        button.tintColor = .white
        let barButtonItem = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButtonItem
    }
}
