//
//  OpinionsData.swift
//  eggTimer2
//
//  Created by Karolina Obszyńska on 17/09/2023.
//

import Foundation

class OpinionsData: Codable {
    let data: [Data]
    }

class Data: Codable {
    
    let date: String
    let rate: Int
    let message: String
    
}
