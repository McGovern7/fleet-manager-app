//
//  APIMethods.swift
//  Fleet-Manager-SwiftUI
//
//  Created by Eli Smith on 12/3/23.
//

import Foundation

class APIObjectRetreiver<T: APIModel>{
    var groupId: Int
    var objectUrl: String
    var baseUrlComponents = URLComponents()
    
    init(objectUrl: String, groupId: Int){
        self.objectUrl = objectUrl
        self.groupId = groupId

        self.baseUrlComponents.scheme = "https"
        self.baseUrlComponents.host = "esmith87.w3.uvm.edu"
        self.baseUrlComponents.path = self.objectUrl
        self.baseUrlComponents.queryItems = [
            URLQueryItem(name: "group_id", value: String(self.groupId))
        ]
    }
    
    func getCollection() -> [T]{
        var components = baseUrlComponents
        components.path = "\(components.path)/list"
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        
        var returnVal: [T] = []
        
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: request){(data, response, error) in
            if let error = error{
                print("There was an error fetching the resource: \(error.localizedDescription)")
            }else if let data = data, let response = response as? HTTPURLResponse{
                if response.statusCode == 200{
                    returnVal = try! JSONDecoder().decode([T].self, from:data)
                }
            }
            semaphore.signal()
        }.resume()
        
        semaphore.wait()
        
        return returnVal
    }
    
    func getObject(key: String) -> T?{
        var components = baseUrlComponents
        components.path = "\(components.path)/list"
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        
        var returnVal: T? = nil
        
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: request){(data, response, error) in
            if let error = error{
                print("There was an error fetching the resource: \(error.localizedDescription)")
            }else if let data = data, let response = response as? HTTPURLResponse{
                if response.statusCode == 200{
                    returnVal = try! JSONDecoder().decode(T.self, from:data)
                }
            }
            semaphore.signal()
        }.resume()
        
        semaphore.wait()
        
        return returnVal
    }
}

let AircraftGetter = APIObjectRetreiver<Aircraft>(objectUrl: "/aircraft", groupId: 1)
let MaintenanceLogEntryGetter = APIObjectRetreiver<MaintenanceLogEntry>(objectUrl: "/maintenance-log-entry", groupId: 1)
let MaintenanceTaskGetter = APIObjectRetreiver<MaintenanceTask>(objectUrl: "/maintenance-task", groupId: 1)
