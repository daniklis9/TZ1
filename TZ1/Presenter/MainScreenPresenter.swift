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
    private let daysArray = ["Сб", "Вс", "Пн", "Вт", "Ср", "Чт", "Пт"]
    private var model: Model?
    private weak var view: ViewControllerProtocol?
    
    func attachView(view: ViewControllerProtocol) {
        self.view = view
    }
    
    func numberOfItems() -> Int {
        guard let model = model, let amountInformation = model.weather_per_day else { return 0}
        return amountInformation.count
    }
    
    func numberOfRows() -> Int {
        guard let model = model, let forecast = model.forecast else { return 0}
        return forecast.count
    }
    
    func setDayAndTemperature(row: Int) -> (day: String, temperature: String) {
        guard let model = model, let perDay = model.weather_per_day, let day = perDay[row].timestamp, let temp = perDay[row].temperature else { return ("", "")}
        return (day, temp)
    }
    
    func setAMPM(row: Int) -> (am: String, pm: String, day: String) {
        var rowForDays: Int = 0
        guard let model = model, let forecast = model.forecast, let am = forecast[row].min_temperature, let pm = forecast[row].max_temperature else { return ("", "", "")}
        
        if row < 7 {
            rowForDays = row
        } else if row == 7{
            rowForDays = 0
        } else{
            rowForDays += 1
        }
        
        let day = daysArray[rowForDays]
        return (am.description, pm.description, day)
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
    
    private func setInformation(model: Model) {
        guard let city = model.city, let description = model.description, let smallInformation = model.temperature else  { return }
        view?.setMainLabels(city: city.localized(), smallInformation: smallInformation, description: description)
    }
}
