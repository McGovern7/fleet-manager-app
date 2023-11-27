//
//  ViewModel.swift
//  Fleet-Manager-SwiftUI
//
//  Created by Luke McGovern on 11/22/23.
//

import Foundation
import SwiftUI

struct Airplane: Hashable, Codable {
    let tail_num: String
    let nfc_uid: Int
    let make: String
    let model: String
    let maintenance_log_id: Int
}

class ViewModel: ObservableObject {
    @Published var airplanes: [Airplane] = []
    
    func fetch() {
        guard let url = URL(string: "https://esmith87.w3.uvm.edu/") else {
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
}
