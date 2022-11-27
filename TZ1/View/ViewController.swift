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
    @IBOutlet private weak var smallInformationView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var tableView: UITableView!
    
    private let tableViewCellId = "TableViewCell"
    private let collectionViewId = "TodayWeatherCell"
    private let presenter = MainScreenPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.attachView(view: self)
        presenter.getInformation()
    }
    
    private func setupView() {
        registerCells()
        smallInformationView.layer.cornerRadius = 14
        tableView.layer.cornerRadius = 14
    }
    
    private func registerCells() {
        self.collectionView.register(UINib(nibName: collectionViewId, bundle: nil), forCellWithReuseIdentifier: collectionViewId)
        self.tableView.register(UINib(nibName: tableViewCellId , bundle: nil), forCellReuseIdentifier: tableViewCellId)
    }
}

extension ViewController: ViewControllerProtocol {
    func setMainLabels(city: String, smallInformation: String, description: String) {
        cityLabel.text = city
        smallWeatherCityInformationLabel.text = smallInformation
        descriptionWeatherLabel.text = description
    }
}

// MARK - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewId, for: indexPath) as! TodayWeatherCell
        let day = presenter.setDayAndTemperature(row: indexPath.row).day
        let temp = presenter.setDayAndTemperature(row: indexPath.row).temperature
        cell.setupCell(day: day, temperature: "\(temp)°")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 43, height: collectionView.bounds.height)
    }
}

// MARK - UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellId, for: indexPath) as! TableViewCell
        let amTemperature = presenter.setAMPM(row: indexPath.row).am
        let pmTemperature = presenter.setAMPM(row: indexPath.row).pm
        let day = presenter.setAMPM(row: indexPath.row).day
        cell.setupCell(amTemperature: amTemperature, pmTemperature: pmTemperature, day: day)
        return cell
    }
}
