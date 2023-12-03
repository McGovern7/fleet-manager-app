
import Foundation

var baseUrlComponents = URLComponents()

baseUrlComponents.scheme = "https"
baseUrlComponents.host = "esmith87.w3.uvm.edu"
baseUrlComponents.path = "/aircraft"
baseUrlComponents.queryItems = [
    URLQueryItem(name: "group_id", value: "1")
]

func getCollection() -> [AircraftModel]{
    var components = baseUrlComponents
    components.path = "\(components.path)/list"
    
    var request = URLRequest(url: components.url!)
    request.httpMethod = "GET"
    
    var returnVal: [AircraftModel] = []
    
    let semaphore = DispatchSemaphore(value: 0)
    
    URLSession.shared.dataTask(with: request){(data, response, error) in
        if let error = error{
            print("There was an error fetching the resource: \(error.localizedDescription)")
        }else if let data = data, let response = response as? HTTPURLResponse{
            if response.statusCode == 200{
                returnVal = try! JSONDecoder().decode([AircraftModel].self, from:data)
            }
        }
        semaphore.signal()
    }.resume()
    
    semaphore.wait()
    
    return returnVal
}

getCollection()
