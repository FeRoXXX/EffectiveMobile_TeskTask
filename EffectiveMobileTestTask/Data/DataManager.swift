//
//  DataManager.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 02.04.2024.
//

import Foundation
import UIKit
import CoreData

class DataManager {
    let data : JsonRequestData?
    var coreDataIds : [CoreDataIds]?
    init() {
        self.data = JsonRequestData.getDataFromJson()
        self.coreDataIds = self.getIdsFromCoreData()
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
    
    func getFavoriteDataFromIds(ids: [CoreDataIds]) -> [Vacancy]? {
        var dataSorted : [Vacancy]? = []
        for item in ids {
            let result = self.getDataFromJson(id: item.id)
            if let result = result {
                dataSorted?.append(result)
            }
        }
        return dataSorted
    }
    
    func getIdsFromCoreData() -> [CoreDataIds]? {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<FavoritesIds> = FavoritesIds.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            var dataArray : [CoreDataIds] = []
            
            for i in results {
                guard let id = i.id else { continue }
                dataArray.append(CoreDataIds(id: id))
            }
            return dataArray
        } catch {
            return nil
        }
    }
    
    func copyFavoriteDataToCoreData() {
        guard let data = data else { return }
        for item in data.vacancies {
            if item.isFavorite {
                saveDataToCoreData(id: item.id)
            }
        }
    }
    
    func saveDataToCoreData(id: UUID) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let favoriteId = FavoritesIds(context: context)
        favoriteId.id = id
        
        do {
            try context.save()
        } catch {
            print("error")
        }
    }
    
    func deleteIdFromCoreData(id: UUID) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<FavoritesIds> = FavoritesIds.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let ids = try context.fetch(fetchRequest)
            
            for id in ids {
                context.delete(id)
            }
            
            try context.save()
        } catch {
            print("error")
        }
    }
}
