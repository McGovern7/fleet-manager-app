//
//  ViewModel.swift
//  Fleet-Manager-SwiftUI
//
//  Created by Luke McGovern on 11/22/23.
//

import Foundation
import SwiftUI

struct Airplane: Hashable, Codable {
    let group_id: Int
    let tail_num: String
    let nfc_uid: Int
    let make: String
    let model: String
    let image: String
}

class ViewModel: ObservableObject {
    @Published var airplanes: [Airplane] = []
    // gets airplane info from url
    func fetch() {
        guard let url = URL(string: "https://esmith87.w3.uvm.edu/aircraft/list") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _,
            error in
            guard let data = data, error == nil else {
                return
            }
            
            // convert to JSON
            do {
                let airplanes = try JSONDecoder().decode([Airplane].self, from: data)
                DispatchQueue.main.async {
                    self?.airplanes = airplanes
                }
            }
            catch {
                print(error)
            }
        }
        
        task.resume()
    }
    // handles "POST" api calls, called in HangarView
    func makePOSTRequest() {
        guard let url = URL(string: "https://esmith87.w3.uvm.edu/aircraft/list") else {
            return
        }
        
        print("making api call...")
        
        var request = URLRequest(url: url)
        
        //  method, body, headers
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "group_id": 1,
            "tail_num": "tail Number",
            "nfc_uid": 50,
            "make": "Boeing",
            "model": "777",
            ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        // make the request
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let response = try JSONDecoder().decode(Airplane.self, from: data)
                print("Success: \(response)")
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    struct Response: Codable {
        let group_id: Int
        let tail_num: String
        let nfc_uid: Int
        let make: String
        let model: String
        let image: String
    }
}


