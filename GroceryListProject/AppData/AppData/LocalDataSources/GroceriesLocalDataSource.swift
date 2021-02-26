//
//  GroceriesLocalDataSource.swift
//  AppData
//
//  Created by Jezreel Barbosa on 11/02/21.
//

public protocol GroceriesLocalDataSource {

    func getGroceryMainList() -> Result<[GroceryListCompleteInfoResponseDTO], Error>
    func saveNewGroceryList(request: GroceryListCompleteInfoResponseDTO) -> Result<Void, Error>
    func removeGroceryList(id: UUID) -> Result<Void, Error>
}
