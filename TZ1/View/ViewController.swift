//
//  ViewController.swift
//  TZ1
//
//  Created by Даниил on 21.11.22.
//

import UIKit

protocol ViewControllerProtocol: AnyObject {
    func setMainLabels(city: String, smallInformation: String, description: String)
}


class ViewController: UIViewController {
    
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var smallWeatherCityInformationLabel: UILabel!
    @IBOutlet private weak var descriptionWeatherLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    
    private let presenter = MainScreenPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        self.collectionView.register(UINib(nibName: "TodayWeatherCell", bundle: nil), forCellWithReuseIdentifier: "TodayWeatherCell")
        presenter.getInformation()
    }
    
//    private func test(row: Int) {
//        presenter.setDayAndTemperature(row: row)
//    }


}

extension ViewController: ViewControllerProtocol {
    func setMainLabels(city: String, smallInformation: String, description: String) {
        cityLabel.text = city
        smallWeatherCityInformationLabel.text = smallInformation
        descriptionWeatherLabel.text = description
    }
    
    //ggreger 
    // geger
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayWeatherCell", for: indexPath) as! TodayWeatherCell
        let day = presenter.setDayAndTemperature(row: indexPath.row).day
        let temp = presenter.setDayAndTemperature(row: indexPath.row).temperature
        cell.setupCell(day: day, temperature: "\(temp)°")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 43, height: collectionView.bounds.height)
    }
    
    
}

