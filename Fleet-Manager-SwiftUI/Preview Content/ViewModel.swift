//
//  ViewModel.swift
//  Fleet-Manager-SwiftUI
//
//  Created by Luke McGovern on 11/22/23.
//

import Foundation
import SwiftUI



class ViewModel: ObservableObject {
    var airplanes: [Aircraft] = AircraftGetter.getCollection()
    var users: [User] = UserGetter.getCollection()
    // gets airplane info from url
    func fetch() {
        self.airplanes = AircraftGetter.getCollection()
        self.users = UserGetter.getCollection()
    }
    // handles "POST" api calls, called in HangarView
    func makePOSTRequest(postRequest: Dictionary<String, AnyHashable>) { // takes the dictionary from makePostRequest
        guard let url = URL(string: "https://esmith87.w3.uvm.edu/aircraft/") else {
            return
        }
        
        print("making api call to log table...")
        
        var request = URLRequest(url: url)
        
        //  method, body, headers
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // Dictionary<String, AnyHashable>
        let body = postRequest // set body to dict from makePostRequest
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        // make the request
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let response = try JSONDecoder().decode(Aircraft.self, from: data)
                print("Success: \(response)")
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func userPOSTRequest(postRequest: Dictionary<String, AnyHashable>) { // takes the dictionary from makePostRequest
        guard let url = URL(string: "https://esmith87.w3.uvm.edu/user/") else {
            return
        }
        
        print("making api call to user table...")
        
        var request = URLRequest(url: url)
        
        //  method, body, headers
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // Dictionary<String, AnyHashable>
        let body = postRequest // set body to dict from makePostRequest
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        // make the request
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let response = try JSONDecoder().decode(Aircraft.self, from: data)
                print("Success: \(response)")
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
}


