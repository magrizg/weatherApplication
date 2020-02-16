//
//  ViewController+viper.swift
//
//  Created by Mikhail Garbuz on 18.10.17.
//  Copyright © 2017 mg. All rights reserved.
//
import UIKit

class Box {
    let value: Any?
    init(_ value: Any?) {
        self.value = value
    }
}

extension UIViewController {
    struct AssociatedKey {
        static var ClosurePrepareForPresenterKey = "ClosurePrepareForPresenterKey"
        static var ClosurePrepareForViewControllerKey = "ClosurePrepareForViewControllerKey"
        static var token = 0
    }
    
    typealias ConfiguratePerformPresenter = (Any?) -> ()
    func performSegue(identifier: String, sender: AnyObject?, configurate: ConfiguratePerformPresenter?) {
        swizzlingPrepareForSegue()
        configuratePerformPresenter = configurate
        performSegue(withIdentifier: identifier, sender: sender)
    }
    
    typealias ConfiguratePerformViewController = (UIViewController?) -> ()
    func performSegueWithConfiguration(identifier: String, sender: AnyObject?, configurate: ConfiguratePerformPresenter?, configurateViewController configurateViewController_: ConfiguratePerformViewController?) {
        swizzlingPrepareForSegue()
        configuratePerformPresenter = configurate
        configurateViewController = configurateViewController_
        performSegue(withIdentifier: identifier, sender: sender)
    }
    
    private func swizzlingPrepareForSegue() {
        let originalSelector = #selector(UIViewController.prepare(for:sender:))
        let swizzledSelector = #selector(UIViewController.closurePrepareForSegue(segue:sender:))
        
        let instanceClass = UIViewController.self
        let originalMethod = class_getInstanceMethod(instanceClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(instanceClass, swizzledSelector)
        
        let didAddMethod = class_addMethod(instanceClass, originalSelector,
                                           method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        
        if didAddMethod {
            class_replaceMethod(instanceClass, swizzledSelector,
                                method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
    
    @objc func closurePrepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var viewController = segue.destination
        if viewController is UINavigationController{
            let controller = viewController as! UINavigationController
            let controllers = controller.viewControllers
            if controllers.count > 0{
                viewController = controllers.first!
            }
        }
        let output = getOutput(viewController: viewController)
        
        configuratePerformPresenter?(output)
        configurateViewController?(viewController)
        closurePrepareForSegue(segue: segue, sender: sender)
        configuratePerformPresenter = nil
        swizzlingPrepareForSegue()
    }
    
    var configuratePerformPresenter: ConfiguratePerformPresenter? {
        get {
            let box = objc_getAssociatedObject(self, &AssociatedKey.ClosurePrepareForPresenterKey) as? Box
            return box?.value as? ConfiguratePerformPresenter
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.ClosurePrepareForPresenterKey, Box(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var configurateViewController: ConfiguratePerformViewController? {
        get {
            let box = objc_getAssociatedObject(self, &AssociatedKey.ClosurePrepareForViewControllerKey) as? Box
            return box?.value as? ConfiguratePerformViewController
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.ClosurePrepareForViewControllerKey, Box(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func getOutput(viewController: UIViewController) -> Any?{
        let variablesViewController = Mirror(reflecting: viewController).children
        for case let (label?, value) in variablesViewController {
            if label == "output"{
                return value
            }
        }
        return nil
    }
}
