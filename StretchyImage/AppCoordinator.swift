//
//  AppCoordinator.swift
//  StretchyImage
//
//  Created by Daria Cheremina on 20/11/2024.
//

import UIKit

protocol AppCoordinatorProtocol: AnyObject {
    func start()
}

final class AppCoordinator: AppCoordinatorProtocol {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let popoverViewController = StretchyImageViewController()

        navigationController.pushViewController(popoverViewController, animated: false)
    }
}
