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
    
    let categoryCell = CategoryCollectionViewCell()
    let presenter = ImageGalleryScreenPresenter()
    
    lazy var collectionView1DelegateDataSource = CollectionView1DelegateDataSource(presenter: self.presenter)
    lazy var collectionView2DelegateDataSource = CollectionView2DelegateDataSource(presenter: self.presenter)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customTitleView = UIView()
        
//         Создайте UILabel для текста заголовка
        
        // Установите пользовательское представление в качестве заголовка
//        navigationItem.titleView = customTitleView
        let backButton = UIBarButtonItem(title: "VKUSSOVET", style: .done, target: self, action: nil)
        
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white, // Цвет текста
            .font: UIFont(name: "Impact", size: 27) ?? UIFont.boldSystemFont(ofSize: 27) // Жирный шрифт
        ]
        
        backButton.setTitleTextAttributes(attributes, for: .normal)
        
        // Устанавливаем созданную кнопку в качестве leftBarButtonItem
        navigationItem.leftBarButtonItem = backButton
//        navigationController?.navigationBar.prefersLargeTitles = true
//        title = "SEEEEEx"
        
        
//        self.view.backgroundColor = UIColor.gray
        collectionView.backgroundColor = .clear
        collectionView.delegate = collectionView1DelegateDataSource
        collectionView.dataSource = collectionView1DelegateDataSource
        collectionView.register(UINib.init(nibName: "CategoryCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        secondCollectionView.delegate = collectionView2DelegateDataSource
        secondCollectionView.dataSource = collectionView2DelegateDataSource
        secondCollectionView.register(UINib.init(nibName: "SecondCategoryCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "SecondCategoryCollectionViewCell")
        secondCollectionView.register(YourHeaderClass.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "YourHeaderReuseIdentifier")
        presenter.attachView(view: self)
        presenter.makeFirstRequest()
        
    }
    
    @objc func backButtonTapped() {
        // Обработка нажатия кнопки "Back"
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
}

class CollectionView1DelegateDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let presenter: ImageGalleryScreenPresenter
    
    init(presenter: ImageGalleryScreenPresenter) {
        self.presenter = presenter
        super.init()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        guard let nameString = presenter.model?.menuList[indexPath.row].name, let quantity =  presenter.model?.menuList[indexPath.row].subMenuCount else { return CategoryCollectionViewCell() }
        if  presenter.categoryImages.count != 0 && presenter.categoryImages.count > 5 {
            cell.imageView.image = presenter.categoryImages[indexPath.row]
            cell.categoryName.text = nameString
            cell.goodsQuantity.text = String(quantity) + " товаров"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = presenter.model else { return }
        let test = model.menuList[indexPath.row].menuID
        presenter.setCategoryName(row: indexPath.row)
        presenter.requestForCategories(menuID: test)
        print(indexPath.row)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: 320)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Устанавливаем отступы для секции (верх, лево, низ, право)
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}




class CollectionView2DelegateDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let presenter: ImageGalleryScreenPresenter
    
    init(presenter: ImageGalleryScreenPresenter) {
        self.presenter = presenter
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.secondNumberOfRows()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCategoryCollectionViewCell", for: indexPath) as! SecondCategoryCollectionViewCell
        cell.backgroundColor = .green
        guard let menuList = presenter.secondModel?.menuList else { return SecondCategoryCollectionViewCell()}
        if  presenter.secondCategoryImages.count != 0 {
            cell.imageView.image = presenter.secondCategoryImages[indexPath.row]
            cell.titleName.text = menuList[indexPath.row].name ?? ""
            cell.subtitleName.text = menuList[indexPath.row].content ?? ""
            cell.priceAndGramsLabel.text = (menuList[indexPath.row].price ?? "") + "р. / " + (menuList[indexPath.row].weight ?? "")
        }
//        cell.mainView.backgroundColor = .red
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2 - 10 // Ширина каждой ячейки (делите на 2, чтобы получить два столбца)
        let height: CGFloat = 280.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "YourHeaderReuseIdentifier", for: indexPath) as! YourHeaderClass
        headerView.titleLabel.text = presenter.getCategoryName()
        return headerView
    }
}


class YourHeaderClass: UICollectionReusableView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textColor = .white
        // Дополнительные настройки вашего заголовка (цвет, шрифт и т.д.)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
//        sectionHeadersPinToVisibleBounds = true
        // Добавьте ваш заголовок к представлению
        addSubview(titleLabel)

        // Настройка constraints для titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
