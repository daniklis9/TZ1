//
//  ImageGalleryScreenPresenter.swift
//  TZ1
//
//  Created by Даниил on 2024/01/14.
//

import Foundation
import UIKit

protocol ImageGalleryScreenPresenterProtocol {
    func attachView(view: ImageGalleryScreenViewProtocol)
    func makeFirstRequest()
    func requestForCategories(menuID: String)
    func numberOfRows() -> Int
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void)
    func setCategoryName(row: Int)
    func getCategoryName() -> String
    func secondNumberOfRows() -> Int
    func cleanTheImages()
}

class ImageGalleryScreenPresenter: ImageGalleryScreenPresenterProtocol {
    
    private var categoryName: String = ""
    public var model: MenuResponse? = nil
    public var secondModel: SecondMenuResponse? = nil
    private let url = URL(string: "https://vkus-sovet.ru/api/getMenu.php")!
    private let secondUrl = URL(string: "https://vkus-sovet.ru/api/getSubMenu.php")!
    public var categoryImages: [UIImage] = []
    public var secondCategoryImages: [UIImage] = []
    
    weak private var view: ImageGalleryScreenViewProtocol?
    
    func attachView(view: ImageGalleryScreenViewProtocol) {
        self.view = view
    }
    
    func numberOfRows() -> Int {
        if let model = model {
            return model.menuList.count
        } else {
            return 0
        }
    }
    
    func secondNumberOfRows() -> Int {
        if let model = secondModel {
            guard let menuList = model.menuList else { return 0 }
            return menuList.count
        } else {
            return 0
        }
    }
    
    func cleanTheImages() {
        self.secondCategoryImages.removeAll()
    }
    
    func setCategoryName(row: Int) {
        guard let model = model else { return }
        self.categoryName = model.menuList[row].name
        self.secondCategoryImages.removeAll()
//        view?.reloadDataAtSecondCollectionView()
    }
    
    func getCategoryName() -> String {
        return self.categoryName
    }
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }.resume()
    }
    
    func makeFirstRequest() {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            } else if let data = data {
                do {
                    self.model = try JSONDecoder().decode(MenuResponse.self, from: data)
                    guard let menuList = self.model?.menuList else { return }
                    for i in menuList {
                        self.loadImage(from: "https://vkus-sovet.ru\(i.image)") { image in
                            guard let image = image else { return }
                            self.categoryImages.append(image)
                            self.view?.reloadData()
                        }
                    }
                    DispatchQueue.main.async {
                        self.view?.reloadData()
                    }
                } catch {
                    print("Ошибка декодирования: \(error)")
                }
            }
        }
        task.resume()
    }
    
    func requestForCategories(menuID: String) {
        let urlString = "https://vkus-sovet.ru/api/getSubMenu.php"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        let parameterString = "menuID=\(menuID)"
        guard let postData = parameterString.data(using: .utf8) else {
            print("Failed to convert parameters to data")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postData
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        self.categoryImages.removeAll()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            } else if let data = data {
                do {
                    self.secondModel = try JSONDecoder().decode(SecondMenuResponse.self, from: data)
                    guard let menuList = self.secondModel?.menuList else { return }
                    for i in menuList {
                        self.loadImage(from: "https://vkus-sovet.ru\(i.image ?? "")") { image in
                            guard let image = image else { return }
                            self.secondCategoryImages.append(image)
                            if self.secondCategoryImages.count == menuList.count {
                                self.view?.reloadDataAtSecondCollectionView()
                            }
//                            self.view?.reloadDataAtSecondCollectionView()
                        }
                    }
//                    DispatchQueue.main.async {
//                        self.view?.reloadDataAtSecondCollectionView()
//                    }
                } catch {
                    print("Ошибка декодирования: \(error)")
                }
            }
        }
        task.resume()
    }
    
    
}
