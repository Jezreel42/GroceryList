//
//  MainListPresenter.swift
//  MainList
//
//  Created by Jezreel Barbosa on 09/01/21.
//

import Domain
import Presentation

public protocol MainListCoordinating: AnyObject {

    func showNewListView(uri: URL?, successCompletion: @escaping VoidCompletion)
    func showGroceryList(uri: URL)
    func didExit()
}

public final class MainListPresenter {

    // Properties

    weak var coordinator: MainListCoordinating?

    public let groceriesBox: Box<[GroceryListHeaderInfoViewModel]>
    public let errorMessageBox: Box<String>
    public let reloadTableViewBox: Box<[Int]>

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
        self.reloadTableViewBox = Box([])

        self.groceriesInfos = []
    }

    deinit {
        coordinator?.didExit()
    }

    // Functions

    func updateList(removingRows: [Int]) {
        let result = getGroceryMainListUseCase.execute()
        result.successHandler { response in
            self.groceriesInfos = response
            self.groceriesBox.value = response.map({ GroceryListHeaderInfoViewModel(response: $0) })

            self.reloadTableViewBox.value = removingRows
        }
        result.failureHandler { error in
            self.errorMessageBox.value = error.localizedDescription
        }
    }
}

extension MainListPresenter: MainListPresenting {

    public func updateList() {
        self.updateList(removingRows: [])
    }

    public func didSelected(row: Int) {
        guard let uri = groceriesInfos.element(at: row)?.uri else {
            self.errorMessageBox.value = "URI Error"
            return
        }
        coordinator?.showGroceryList(uri: uri)
    }

    public func createNewList() {
        coordinator?.showNewListView(uri: nil) { [weak self] in
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
            self.updateList(removingRows: [row])
        }
        result.failureHandler { error in
            self.errorMessageBox.value = error.localizedDescription
        }
    }

    public func editItem(at row: Int) {
        guard let uri = groceriesInfos.element(at: row)?.uri else {
            self.errorMessageBox.value = "URI Error"
            return
        }
        coordinator?.showNewListView(uri: uri) { [weak self] in
            self?.updateList()
        }
    }
}
