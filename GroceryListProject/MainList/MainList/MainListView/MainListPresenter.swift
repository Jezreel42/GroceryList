//
//  MainListPresenter.swift
//  MainList
//
//  Created by Jezreel Barbosa on 09/01/21.
//

import Domain

public protocol MainListCoordinating: AnyObject {

    func showNewListView(successCompletion: @escaping VoidCompletion)
    func showGroceryList(uri: URL)
    func didExit()
}

public final class MainListPresenter {

    // Properties

    weak var coordinator: MainListCoordinating?

    public let groceriesBox: Box<[GroceryListHeaderInfoViewModel]>
    public let errorMessageBox: Box<String>
    public let removeRowBox: Box<Int?>
    public var reloadTableView: VoidCompletion

    private let getGroceryMainListUseCase: GetGroceryMainListUseCaseProtocol
    private let removeGroceryListUseCase: RemoveGroceryListUseCaseProtocol

    private var groceriesInfos: [GroceryListModel]

    // Lifecycle

    public init(coordinator: MainListCoordinating,
                getGroceryMainListUseCase: GetGroceryMainListUseCaseProtocol,
                removeGroceryListUseCase: RemoveGroceryListUseCaseProtocol) {
        self.coordinator = coordinator
        self.getGroceryMainListUseCase = getGroceryMainListUseCase
        self.removeGroceryListUseCase = removeGroceryListUseCase

        self.groceriesBox = Box([])
        self.errorMessageBox = Box("")
        self.removeRowBox = Box(nil)

        self.groceriesInfos = []
        self.reloadTableView = {}
    }

    deinit {
        coordinator?.didExit()
    }

    // Functions

    func updateList(hasToReloadTableView: Bool) {
        let result = getGroceryMainListUseCase.execute()
        result.successHandler { response in
            self.groceriesInfos = response
            self.groceriesBox.value = response.map({ GroceryListHeaderInfoViewModel(response: $0) })

            guard hasToReloadTableView else { return }

            self.reloadTableView()
        }
        result.failureHandler { error in
            self.errorMessageBox.value = error.localizedDescription
        }
    }
}

extension MainListPresenter: MainListPresenting {

    public func updateList() {
        self.updateList(hasToReloadTableView: true)
    }

    public func didSelected(row: Int) {
        guard let uri = groceriesInfos.element(at: row)?.uri else {
            self.errorMessageBox.value = "URI Error"
            return
        }
        coordinator?.showGroceryList(uri: uri)
    }

    public func createNewList() {
        coordinator?.showNewListView { [weak self] in
            self?.updateList()
        }
    }

    public func deleteItem(at row: Int) {
        guard let uri = groceriesInfos.element(at: row)?.uri else {
            self.errorMessageBox.value = "URI Error"
            return
        }

        let result = removeGroceryListUseCase.execute(uri: uri)
        result.successHandler { _ in
            self.updateList(hasToReloadTableView: false)
            self.removeRowBox.value = row
        }
        result.failureHandler { error in
            self.errorMessageBox.value = error.localizedDescription
        }
    }
}
