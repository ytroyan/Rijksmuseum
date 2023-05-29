//
//  File.swift
//  Rijksmuseum
//
//  Created by Troian on 28.05.2023.
//

import Foundation
import UIKit

protocol MainInteractorDelegate: InteractorDelegate {
    func showDetailArtObject(id: String)
}

protocol InteractorDelegate: AnyObject {
    func showAlertMessage(message: String)
}

final class MainCoordinator {
    private let window: UIWindow
    
    weak var mainNavigation: UINavigationController?
        
    init(scene: UIWindowScene) {
        self.window = UIWindow(windowScene: scene)
    }
    
    func start() {
        let vc = UIViewController()
        let navVC = UINavigationController(rootViewController: vc)
        window.rootViewController = navVC
        mainNavigation = navVC
        window.makeKeyAndVisible()
    }
}

extension MainCoordinator: MainInteractorDelegate {
    func showDetailArtObject(id: String) {
        let vc = UIViewController()
        mainNavigation?.showDetailViewController(vc, sender: self)
    }
}

extension MainCoordinator: InteractorDelegate {
    func showAlertMessage(message: String) {
        let alertView = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alertView.addAction(action)
        self.mainNavigation?.present(alertView, animated: true)
    }
}
