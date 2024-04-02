//
//  DataManager.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 02.04.2024.
//

import Foundation

class DataManager {
    let data : JsonRequestData?
    init() {
        self.data = JsonRequestData.getDataFromJson()
    }
}

extension DataManager : DataManagerProtocol {
    func getDataFromJson() -> JsonRequestData? {
        return data
    }
    
    func getDataFromJson(id: UUID) -> Vacancy? {
        guard let data = data else { return nil }
        for item in data.vacancies {
            if item.id == id {
                return item
            }
        }
        return nil
    }
    
    func getFavoriteData() -> [Vacancy]? {
        guard let data = data else { return nil}
        var favoriteVacancies : [Vacancy]? = []
        for item in data.vacancies {
            if item.isFavorite {
                favoriteVacancies?.append(item)
            }
        }
        return favoriteVacancies
    }
}
