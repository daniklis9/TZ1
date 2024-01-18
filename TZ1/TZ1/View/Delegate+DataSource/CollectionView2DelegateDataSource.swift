//
//  CollectionView2DelegateDataSource.swift
//  TZ1
//
//  Created by Даниил on 2024/01/17.
//

import Foundation
import UIKit

class CollectionView2DelegateDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private let presenter: ImageGalleryScreenPresenter
    private let secondCategoryCollectionViewCellID = "SecondCategoryCollectionViewCell"
    private let imageSpicy = UIImage(named: "perec")
    
    init(presenter: ImageGalleryScreenPresenter) {
        self.presenter = presenter
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.secondNumberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: secondCategoryCollectionViewCellID, for: indexPath) as! SecondCategoryCollectionViewCell
        guard let menuList = presenter.secondModel?.menuList else { return SecondCategoryCollectionViewCell()}
        
        if  presenter.secondCategoryImages.count != 0 {
            cell.setupImage(image: presenter.secondCategoryImages[indexPath.row])
            cell.setupLabels(titleName: menuList[indexPath.row].name ?? "", subTitleName: menuList[indexPath.row].content ?? "", priceAndGrams: (menuList[indexPath.row].price ?? "") + "р. / " + (menuList[indexPath.row].weight ?? ""))
            menuList[indexPath.row].spicy == "Y" ?  cell.setupSpicyImage(image: imageSpicy!) : cell.setupSpicyImage(image: nil)
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2 - 10
        let height: CGFloat = 280.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderID", for: indexPath) as! HeaderClass
        headerView.titleLabel.text = presenter.getCategoryName()
        return headerView
    }
}
