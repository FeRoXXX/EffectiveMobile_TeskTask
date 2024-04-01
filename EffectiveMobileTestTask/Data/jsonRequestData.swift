//
//  JsonRequestData.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 31.03.2024.
//

import Foundation
import UIKit

struct JsonRequestData: Codable {
    let offers: [Offer]
    let vacancies: [Vacancy]
    
    static func getDataFromJson() -> JsonRequestData? {
        var requestData : JsonRequestData?
        let path = Bundle.main.url(forResource: "request", withExtension: "json")
        guard let path = path else { return nil }
        let data = try? Data(contentsOf: path)
        guard let data = data else { return nil }
        do {
            requestData = try JSONDecoder().decode(JsonRequestData.self, from: data)
            return requestData
        } catch {
            print("Error decoding JSON:", error)
            return nil
        }
    }
}

struct Offer: Codable {
    let id: String?
    let title: String
    let link: URL
    let button: Button?
}

struct Button: Codable {
    let text: String
}

struct Vacancy: Codable {
    let id: UUID
    let lookingNumber: Int?
    let title: String
    let address: Address
    let company: String
    let experience: Experience
    let publishedDate: String
    let isFavorite: Bool
    let salary: Salary
    let schedules: [String]
    let appliedNumber: Int?
    let description: String?
    let responsibilities: String
    let questions: [String]
}

struct Address: Codable {
    let town: String
    let street: String
    let house: String
}

struct Experience: Codable {
    let previewText: String
    let text: String
}

struct Salary: Codable {
    let short: String?
    let full: String
}
