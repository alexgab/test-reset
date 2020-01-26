//
//  BaseInteractor.swift
//  Scop
//
//  Created by Igor Mikheiko on 01.04.2018.
//  Copyright © 2018 Scope One Inc. All rights reserved.
//

import Foundation
import UIKit

public protocol Presenter {
    
}

public class BaseInteractor<T: BaseCoordinator> {
    
    private weak var viewController: UIViewController?
    private let coordinator: T
    
    required public init(viewController: UIViewController, coordinator: T) {
        self.viewController = viewController;
        self.coordinator = coordinator
    }
    
    func presenter<P: Presenter>() -> P  {
        guard let presenter = viewController as? P else {
            preconditionFailure("Presenter (BaseViewController) not defined or already released")
        }
        
        return presenter
    }
    
    public func `continue`(withResult: AnyObject?) {
        
    }
}
