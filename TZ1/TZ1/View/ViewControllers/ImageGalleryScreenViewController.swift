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
    
    private let categoryCollectionViewCellID = "CategoryCollectionViewCell"
    private let secondCategoryCollectionViewCellID = "SecondCategoryCollectionViewCell"
    private let headerID = "HeaderID"
    let categoryCell = CategoryCollectionViewCell()
    let presenter = ImageGalleryScreenPresenter()
    lazy var collectionView1DelegateDataSource = CollectionView1DelegateDataSource(presenter: self.presenter)
    lazy var collectionView2DelegateDataSource = CollectionView2DelegateDataSource(presenter: self.presenter)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
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
}
