//
//  BaseNavigationController.swift
//  Scop
//
//  Created by Igor Mikheiko on 01.04.2018.
//  Copyright © 2018 Scope One Inc. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    private var coordinator: RootCoordinator?
    
    public func instantiateRootCoordinator() -> RootCoordinator {
        preconditionFailure("This method must be overridden")
    }
    
    override var shouldAutorotate: Bool {
        get {
            if let viewController = self.topViewController {
                return viewController.shouldAutorotate
            } else {
                return false
            }
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            if let viewController = self.topViewController {
                return viewController.supportedInterfaceOrientations
            } else {
                return .portrait
            }
        }
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        get {
            if let viewController = self.topViewController {
                return viewController.preferredInterfaceOrientationForPresentation
            } else {
                return .portrait
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator = instantiateRootCoordinator();
        coordinator?.route(from: nil)
    }
}
