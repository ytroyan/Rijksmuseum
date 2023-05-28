//
//  File.swift
//  Rijksmuseum
//
//  Created by Troian on 28.05.2023.
//

import Foundation
import UIKit

final class MainCoordinator {
    private let window: UIWindow
    
    weak var mainNavigation: UINavigationController?
        
    init(scene: UIWindowScene) {
        self.window = UIWindow(windowScene: scene)
    }
    
    func start() {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        let navVC = UINavigationController(rootViewController: vc)
        window.rootViewController = navVC
        mainNavigation = navVC
        window.makeKeyAndVisible()
    }
}
