//
//  CollectionView1DelegateDataSource.swift
//  TZ1
//
//  Created by Даниил on 2024/01/17.
//

import Foundation
import UIKit

class CollectionView1DelegateDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var selectedIndexPath: IndexPath?
    private let presenter: ImageGalleryScreenPresenter
    private let categoryCollectionViewCellID = "CategoryCollectionViewCell"
    private let goodsString = " товаров"
    
    init(presenter: ImageGalleryScreenPresenter) {
        self.presenter = presenter
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCollectionViewCellID, for: indexPath) as! CategoryCollectionViewCell
        cell.contentView.backgroundColor = (indexPath == selectedIndexPath) ? UIColor.blue : UIColor.clear
        guard let nameString = presenter.model?.menuList[indexPath.row].name, let quantity =  presenter.model?.menuList[indexPath.row].subMenuCount else { return CategoryCollectionViewCell() }
        if  presenter.categoryImages.count != 0 && presenter.categoryImages.count > 5 {
            cell.setupImage(image: presenter.categoryImages[indexPath.row])
            cell.setCategoryName(name: nameString)
            cell.setGoodsQuantity(quantity: String(quantity) + goodsString)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.2) {
            collectionView.cellForItem(at: indexPath)?.contentView.backgroundColor = UIColor.blue
        }
        self.selectedIndexPath = indexPath
        guard let model = presenter.model else { return }
        let menuID = model.menuList[indexPath.row].menuID
        presenter.setCategoryName(row: indexPath.row)
        presenter.requestForCategories(menuID: menuID)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2) {
            collectionView.cellForItem(at: indexPath)?.contentView.backgroundColor = UIColor.clear
        }
        selectedIndexPath = nil
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: 320)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
