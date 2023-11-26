//
//  ScanView.swift
//  Fleet-Manager-SwiftUI
//
//  Created by Eli Smith on 11/24/23.
//

import SwiftUI

let json = """
[{"tail_num":"N804BT","nfc_uid":268435455,"make":"Cessna","model":"172 Skyhawk","maintenance_log_id":1234},{"tail_num":"N805BT","nfc_uid":268435455,"make":"Cessna","model":"172 Skyhawk","maintenance_log_id":1234},{"tail_num":"N806BT","nfc_uid":268435455,"make":"Cessna","model":"182 Skyhawk","maintenance_log_id":1234}]
""".data(using:.utf8)!

struct AircraftModel: Codable {
    var tail_num: String
    var nfc_uid: Int64
    var make: String
    var model: String
    var maintenance_log_id: Int
}

let decoder = JSONDecoder()
let products = try! decoder.decode([AircraftModel].self, from:json)

func printJSONElements() {
    for product in products{
        print("\(product)")
    }
}

struct ScanView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        VStack(){
            Text("Aircraft Search")
                .font(.largeTitle)
                .padding(20)
                .padding(.top, 50)
                .frame(
                    maxWidth: .infinity,
                    alignment: .center
                  )
              .background(Color(red: 56/255, green: 223/255, blue: 223/255)
                  .ignoresSafeArea())
              .clipShape(
                  .rect(
                      bottomLeadingRadius: 30,
                      bottomTrailingRadius: 30
                  )
              )
            NavigationStack(){
                List{
                    ForEach(filteredAircraft, id: \.self.tail_num){ item in
                        VStack(alignment: .leading){
                            Text("\(item.tail_num)")
                                .font(.headline)
                            Text("\(item.make) \(item.model)")
                                .font(.subheadline)
                        }
                    }
                }
                .toolbar{
                    ToolbarItem(placement: .bottomBar){
                        HStack{
                            Button(action:printJSONElements){
                                Image(systemName:"sensor.tag.radiowaves.forward")
                                    .font(.title)
                                    .foregroundColor(.accentColor)
                                Text("Scan")
                                    .foregroundColor(.accentColor)
                                
                            }
                            .fontWeight(.bold)
                            .padding(2)
                            .background(Color.primary)
                            .clipShape(
                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            )
                        }.padding(.bottom, 40)
                    }
                }
            }
            .searchable(text:$searchText)
            
        }
    }
    
    var filteredAircraft: [AircraftModel]{
        if searchText.isEmpty {
            return products
        }else{
            return products.filter{
                $0.tail_num.contains(searchText)
                || $0.model.contains(searchText)
                || $0.make.contains(searchText)
            }
        }
    }
}

#Preview {
    VStack(){
        ScanView()
        Spacer()
    }
    .ignoresSafeArea()
}
