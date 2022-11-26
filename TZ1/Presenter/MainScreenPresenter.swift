//
//  MainScreenPresenter.swift
//  TZ1
//
//  Created by Даниил on 26.11.22.
//

import Foundation


class MainScreenPresenter {
    private let resource = "TestTaskJSON"
    private let type = "json"
    
    private var model: Model?
    private weak var view: ViewControllerProtocol?
    
    func attachView(view: ViewControllerProtocol) {
        self.view = view
    }
    
    func getInformation() {
        guard let path = Bundle.main.path(forResource: resource, ofType: type) else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            model = try! JSONDecoder().decode(Model.self, from: data)
            guard let model = model else { return }
            setInformation(model: model)
        } catch {
            print(error)
        }
    }
    
    func numberOfItems() -> Int {
        guard let model = model, let amountInformation = model.weather_per_day else { return 0}
        return amountInformation.count
    }
    
    func setDayAndTemperature(row: Int) -> (day: String, temperature: String) {
        guard let model = model, let perDay = model.weather_per_day, let day = perDay[row].timestamp, let temp = perDay[row].temperature else { return ("", "")}
        return (day, temp)
    }
    
    private func setInformation(model: Model) {
        guard let city = model.city, let description = model.description, let smallInformation = model.temperature else  { return }
        view?.setMainLabels(city: city.localized(), smallInformation: smallInformation, description: description)
        
        // city.localized() Добавил локализацию, так как Минск умудрились засунуть в JSON на агл
    }
}
