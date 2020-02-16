//
//  RouterBase.swift
//
//  Created by Mikhail Garbuz on 18.10.17.
//  Copyright © 2017 mg. All rights reserved.
//

import UIKit

let kNameStoryboardMain = "Main"

protocol TransitionablePresenter {
    func transitionDelegate() -> UIViewControllerTransitioningDelegate?
}

class RouterBase {
    weak var transitionHandler: UIViewController!
    
    typealias ConfiguratePerformPresenter = (Any?) -> ()
    typealias ConfiguratePerformViewController = (UIViewController?) -> ()
    
    func perform(segueIdentifier: String, sender: AnyObject?, configurate: ConfiguratePerformPresenter?){
        transitionHandler.performSegue(identifier: segueIdentifier, sender: sender, configurate: configurate)
    }
    
    func perform(segueIdentifier: String, configurate: ConfiguratePerformPresenter?){
        perform(segueIdentifier: segueIdentifier, sender: nil, configurate: configurate)
    }
    
    func perform(segueIdentifier: String, configurate: ConfiguratePerformPresenter?, configurateViewController: ConfiguratePerformViewController?){
        transitionHandler.performSegueWithConfiguration(identifier: segueIdentifier, sender: nil, configurate: configurate, configurateViewController: configurateViewController)
    }
    
    func perform(segueIdentifier: String){
        perform(segueIdentifier: segueIdentifier, configurate: nil)
    }
    
    func closeModule(){
        closeModule(completion: nil)
    }
    
    func closeModule(completion: (() -> Void)?){
        if let navigationController = transitionHandler.navigationController{
            if navigationController.viewControllers.count > 1{
                navigationController.popViewController(animated: true)
                if let completion = completion{
                    completion()
                }
                return
            }
            navigationController.dismiss(animated: true, completion: completion)
            return
        }
        transitionHandler.dismiss(animated: true, completion: completion)
    }
}
