//
//  DataManagerProtocol.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 02.04.2024.
//

import Foundation

protocol DataManagerProtocol {
    func getDataFromJson() -> JsonRequestData?
    func getDataFromJson(id: UUID) -> Vacancy?
    func getFavoriteData() -> [Vacancy]?
    func getIdsFromCoreData() -> [CoreDataIds]?
    func saveDataToCoreData(id: UUID)
    func deleteIdFromCoreData(id: UUID)
    func getFavoriteDataFromIds(ids: [CoreDataIds]) -> [Vacancy]?
    func copyFavoriteDataToCoreData()
}
