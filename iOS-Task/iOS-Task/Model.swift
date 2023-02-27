//
//  Model.swift
//  iOS-Task
//
//  Created by Kullanici on 26.02.2023.
//

import Foundation
struct ArrayModel : Codable, Identifiable {
    var id: String {
        return task
    }
    
    var task : String
    var title : String
    var description : String
    var sort : String
    var wageType : String
    var BusinessUnitKey : String?
    var businessUnit : String?
    var parentTaskID : String?
    var preplanningBoardQuickSelect : String?
    var colorCode : String?
    var workingTime : String?
    var isAvailableInTimeTrackingKioskMode : Bool
    
}
