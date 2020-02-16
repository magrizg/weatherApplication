//
//  CityDescriptionPresenter.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 14/02/2020.
//  Copyright © 2020 mg. All rights reserved.
//

class CityDescriptionPresenter: CityDescriptionModuleInput, CityDescriptionViewOutput, CityDescriptionInteractorOutput {

    weak var view: CityDescriptionViewInput!
    var interactor: CityDescriptionInteractorInput!
    var router: CityDescriptionRouterInput!
    
    private var forecastModel: ForecastModel!

    //MARK: CityDescriptionModuleInput
    func configureModule(forecastModel: ForecastModel){
        self.forecastModel = forecastModel
    }
    
    //MARK: CityDescriptionViewOutput
    func viewIsReady() {
        view.setTitle(name: forecastModel.name)
        var arrayCellViewModels = [CityDescriptionCellViewModel]()
        
        arrayCellViewModels.append(CityDescriptionCellViewModel.init(leftString: "Temperature", rightString: String.string(temperature: forecastModel.tempToday)))
        arrayCellViewModels.append(CityDescriptionCellViewModel.init(leftString: "Max", rightString: String.string(temperature: forecastModel.tempMaxToday)))
        arrayCellViewModels.append(CityDescriptionCellViewModel.init(leftString: "Min", rightString: String.string(temperature: forecastModel.tempMinToday)))
        arrayCellViewModels.append(CityDescriptionCellViewModel.init(leftString: "Pressure", rightString: "\(forecastModel.pressureToday)"))
        arrayCellViewModels.append(CityDescriptionCellViewModel())
        arrayCellViewModels.append(CityDescriptionCellViewModel.init(leftString: "TemperatureNext1Day", rightString: String.string(temperature: forecastModel.tempNext1Day)))
        arrayCellViewModels.append(CityDescriptionCellViewModel.init(leftString: "TemperatureNext2Day", rightString: String.string(temperature: forecastModel.tempNext2Day)))
        arrayCellViewModels.append(CityDescriptionCellViewModel.init(leftString: "TemperatureNext3Day", rightString: String.string(temperature: forecastModel.tempNext3Day)))
        
        view.set(viewModels: arrayCellViewModels)
    }
    
    func pressButton(){
        view.showAlertRemove()
    }
    
    func pressButtonRemoveConfirm(){
        interactor.remove(forecast: forecastModel)
    }
    
    //MARK: CityDescriptionInteractorOutput
    func removeCompleted() {
        router.closeModule()
    }
}
