//
//  StaticDataForFastFilters.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 30.03.2024.
//

import Foundation
import UIKit

struct StaticDataForFastFilters {
    var image: UIImage
    var text: NSMutableAttributedString
    var secondaryText: NSAttributedString?
    var imageBackground: UIColor
}

extension StaticDataForFastFilters {
    static let data = [
        StaticDataForFastFilters(image: UIImage(named: "Vacancy")!, text: NSMutableAttributedString(string: "Вакансии рядом с вами", attributes: [.font : UIFont.systemFont(ofSize: 14)]), imageBackground: UIColor(red: 0, green: 66/255, blue: 125/255, alpha: 1)),
        StaticDataForFastFilters(image: UIImage(named: "Raise")!, text: NSMutableAttributedString(string: "Поднять резюме в поиске", attributes: [.font : UIFont.systemFont(ofSize: 14)]), secondaryText: NSAttributedString(string: "Поднять"), imageBackground: UIColor(red: 1/255, green: 89/255, blue: 5/255, alpha: 1)),
        StaticDataForFastFilters(image: UIImage(named: "Part.time")!, text: NSMutableAttributedString(string: "Временная работа и подработки", attributes: [.font : UIFont.systemFont(ofSize: 14)]), imageBackground: UIColor(red: 1/255, green: 89/255, blue: 5/255, alpha: 1))
    ]
}
