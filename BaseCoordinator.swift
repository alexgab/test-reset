//
//  BaseCoordinator.swift
//  Scop
//
//  Created by Igor Mikheiko on 01.04.2018.
//  Copyright © 2018 Scope One Inc. All rights reserved.
//

import Foundation
import UIKit

public class BaseCoordinator {
    
    public let identifier: String
    
    public let rootCoordinator: RootCoordinator
    
    private var storyboard: UIStoryboard? = nil
    
    public required init(identifier: String, rootCoordinator: RootCoordinator) {
        self.identifier = identifier
        self.rootCoordinator = rootCoordinator
        self.storyboard = defaultStoryboard()
    }
    
    public class func defaultIdentifier() -> String {
        preconditionFailure("This method must be overridden")
    }
    
    public func defaultStoryboard() -> UIStoryboard? {
        preconditionFailure("This method must be overridden")
    }
    
    public func initialViewController() -> UIViewController {
        preconditionFailure("This method must be overridden")
    }
    
    public func configure() {
        preconditionFailure("This method must be overridden")
    }
    
    public func `continue`(from identifier: String, withResult result: AnyObject?) {
        preconditionFailure("This method must be overridden")
    }
    
    public func finish() {
        rootCoordinator.route(from: self)
    }
    
    func instantiateViewController(identifier: String? = nil, fromStoryboard: UIStoryboard? = nil) -> UIViewController {
        var viewController: UIViewController?
        
        if let storyboard = fromStoryboard ?? self.storyboard {
            if let identifier = identifier {
                viewController = storyboard.instantiateViewController(withIdentifier: identifier)
            } else {
                viewController = storyboard.instantiateInitialViewController()
            }
        }
        
        if let viewController = viewController as? BaseViewController {
            configure(viewController: viewController)
            return viewController as! UIViewController
        }
        
        preconditionFailure("Can't instantiate ViewController with identifier \"\(identifier ?? "initial")\"")
    }
    
    func push(identifier: String? = nil, fromStoryboard: UIStoryboard? = nil, withData: AnyObject? = nil, animated: Bool = true) {
        push(viewController: instantiateViewController(identifier: identifier, fromStoryboard: fromStoryboard),
             withData: withData,
             animated: animated)
    }
    
    func present(identifier: String? = nil, fromStoryboard: UIStoryboard? = nil, withData: AnyObject? = nil, animated: Bool = true) {
        present(viewController: instantiateViewController(identifier: identifier, fromStoryboard: fromStoryboard),
                withData: withData,
                animated: animated)
    }
    
    func push(viewController: UIViewController, withData: AnyObject? = nil, animated: Bool = true) {
        rootCoordinator.navigationController().pushViewController(viewController, animated: animated)
    }
    
    func present(viewController: UIViewController, withData: AnyObject? = nil, animated: Bool = true) {
        rootCoordinator.navigationController().present(viewController, animated: animated) {
            
        }
    }
    
    func pop(animated: Bool = true) {
        rootCoordinator.navigationController().popViewController(animated: animated)
    }
    
    private func configure(viewController: BaseViewController) {

    }
}
