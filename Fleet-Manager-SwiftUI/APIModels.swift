//
//  APIModels.swift
//  Fleet-Manager-SwiftUI
//
//  Created by Eli Smith on 12/3/23.
//

struct AircraftModel: Codable {
    var tail_num: String
    var nfc_uid: Int64
    var make: String
    var model: String
    var maintenance_log_id: Int
    var maintenance_log: [MaintenanceLogEntry]
    var group_id: Int
}

struct MaintenanceLogEntry: Codable {
    var log_entry_id: Int
    var aircraft_tail_num: String
    var maintenance_task_id: Int
    var maintenance_task: [MaintenanceTask]
    var required_completion_date: String
    var status: String
    var completion_date: String
    var group_id: Int
}

struct MaintenanceTask: Codable {
    var task_id: Int
    var title: String
    var description: String
    var recurring: Bool
    var recurrence_interval_days: Int
    var group_id: Int
}

struct UserGroup: Codable {
    var group_id: Int
    var name: String
}

struct User: Codable {
    var name: String
    var password: String
    var group_id: Int
}
