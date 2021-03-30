//
//  RemoveGroceryListUseCase.swift
//  Domain
//
//  Created by Jezreel Barbosa on 21/02/21.
//

public protocol RemoveGroceryListUseCaseProtocol {

    func execute(uri: URL) -> Result<Void, Error>
}

public class RemoveGroceryListUseCase {

    let repository: GroceriesRepository

    public init(repository: GroceriesRepository) {
        self.repository = repository
    }
}

extension RemoveGroceryListUseCase: RemoveGroceryListUseCaseProtocol {

    public func execute(uri: URL) -> Result<Void, Error> {
        repository.removeGroceryList(uri: uri)
    }
}
