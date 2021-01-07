//
//  CoordinatorAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Swinject
import Common
import AppNavigation

class CoodinatorAssembly {

    private let launchOptions: LaunchOptions?
    private let window: UIWindow?

    init(launchOptions: LaunchOptions?, window: UIWindow?) {
        self.launchOptions = launchOptions
        self.window = window
    }

    private func assembleAppCoordinator(container: Container) {
        let navigationController = UINavigationController()
        let coordinatorsFactory = container.resolveSafe(AppCoordinatorsFactoryProtocol.self)
        container.register(AppCoordinator.self) { _ in
            AppCoordinator(with: self.launchOptions, window: self.window, navigationController: navigationController,
                           coordinatorsFactory: coordinatorsFactory)
        }
    }
}

extension CoodinatorAssembly: Assembly {

    func assemble(container: Container) {
        assembleAppCoordinator(container: container)
    }
}