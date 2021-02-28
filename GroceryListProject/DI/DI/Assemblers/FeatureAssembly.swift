//
//  FeatureAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Swinject
import Domain
import AppNavigation
import MainList
import GroceryList

class FeatureAssembly {

    func assembleMainList(container: Container) {
        let coordinator = container.resolveSafe(MainListCoordinator.self)
        container.register(MainListCoordinating.self) { _ in coordinator }
        container.autoregister(MainListPresenting.self, initializer: MainListPresenter.init)

        container.register(NewListPresenting.self) { (resolver: Resolver, successCompletion: @escaping VoidCompletion) in
            NewListPresenter(
                createNewGroceryListUseCase: resolver.resolveSafe(CreateNewGroceryListUseCaseProtocol.self),
                successCompletion: successCompletion
            )
        }
    }

    func assembleGroceryList(container: Container) {
        container.register(GroceryListPresenting.self) { (resolver: Resolver, id: UUID) in
            GroceryListPresenter(
                groceryListID: id, coordinator: resolver.resolveSafe(GroceryListCoordinator.self),
                createNewGroceryListUseCase: resolver.resolveSafe(CreateNewGroceryListUseCaseProtocol.self)
            )
        }
    }
}

extension FeatureAssembly: Assembly {

    func assemble(container: Container) {
        assembleMainList(container: container)
        assembleGroceryList(container: container)
    }
}