//
//  APIModels.swift
//  Fleet-Manager-SwiftUI
//
//  Created by Eli Smith on 12/3/23.
//

protocol APIModel: Hashable, Decodable{
    
}

struct Aircraft: Codable, APIModel {
    var group_id: Int
    var tail_num: String
    var nfc_uid: Int64
    var make: String
    var model: String
    var image: String
    var maintenance_log: [MaintenanceLogEntry]
}

struct MaintenanceLogEntry: Codable, APIModel {
    var group_id: Int
    var log_entry_id: Int
    var aircraft_tail_num: String
    var maintenance_task_id: Int
    var maintenance_task: MaintenanceTask
    var required_completion_date: String
    var status: String
    var completion_date: String
}

struct MaintenanceTask: Codable, APIModel {
    var group_id: Int
    var task_id: Int
    var title: String
    var description: String
    var recurring: Bool
    var recurrence_interval_days: Int
}

struct UserGroup: Codable, APIModel {
    var group_id: Int
    var name: String
}

struct User: Codable, APIModel {
    var name: String
    var password: String
    var group_id: Int
}

//struct PostRequestModel: Codable, ApiModel {
//    
//}
