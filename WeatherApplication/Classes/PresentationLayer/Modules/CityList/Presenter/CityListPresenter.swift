//
//  CityListPresenter.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 13/02/2020.
//  Copyright © 2020 mg. All rights reserved.
//

class CityListPresenter: CityListModuleInput, CityListViewOutput, CityListInteractorOutput {

    weak var view: CityListViewInput!
    var interactor: CityListInteractorInput!
    var router: CityListRouterInput!
    
    private var cityName: String?

    //MARK: CityListViewOutput
    
    func viewWillAppear() {
        interactor.getForecastsAndUpdate()
    }
    
    func change(cityName: String?){
        self.cityName = cityName
        checkText()
    }
    
    func buttonPressed(){
        if let cityName = cityName{
            interactor.searchCity(name: cityName)
        }
    }
    
    //MARK: CityListInteractorOutput
    func updated(forecasts: [ForecastModel]){
        let didSelect: TDMDidSelectCell = {[weak self] (vm) in
            let model = vm as! CityCellViewModel
            self?.selectCity(forecast: model.forecast)
        }
        var arrayCellViewModels = [CityCellViewModel]()
        for forecast in forecasts{
            arrayCellViewModels.append(CityCellViewModel.init(forecast: forecast, didSelect: didSelect))
        }
        view.set(viewModels: arrayCellViewModels)
    }
    
    func errorLoad(message: String) {
        view.showError(error: message)
    }
    
    //MARK: Private methods
    private func selectCity(forecast: ForecastModel){
        router.openCityDescription(forecastModel: forecast)
    }
    
    private func checkText(){
        let string = cityName ?? ""
        view.changeButton(enabled: string.count > 2)
    }
}
