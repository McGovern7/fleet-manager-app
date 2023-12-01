//
//  ScanView.swift
//  Fleet-Manager-SwiftUI
//
//  Created by Eli Smith on 11/24/23.
//

import SwiftUI
import CoreNFC

// Only thing that differs is the tail num
let json = """
[{"tail_num":"N804BT","nfc_uid":1192538920397441,"make":"Cessna","model":"172 Skyhawk","maintenance_log_id":1234},{"tail_num":"N805BT","nfc_uid":1238409120787073,"make":"Cessna","model":"172 Skyhawk","maintenance_log_id":1234},{"tail_num":"N806BT","nfc_uid":268435455,"make":"Cessna","model":"182 Skyhawk","maintenance_log_id":1234}]
""".data(using:.utf8)!

struct AircraftModel: Codable {
    var tail_num: String
    var nfc_uid: Int64
    var make: String
    var model: String
    var maintenance_log_id: Int
}

// Try to decode JSON data with the expectation that it conforms to a structure.
// In this case, the structure is an array of AircraftModel structs, which the
// example JSON string conforms to.
let decoder = JSONDecoder()
let products = try! decoder.decode([AircraftModel].self, from:json)

struct ScanView: View {
    
    @ObservedObject var NFCR = MiFareReader()
    
    @State private var searchText = ""
    
    let titleFont = Font.largeTitle.lowercaseSmallCaps()
    
    var body: some View {
        VStack(){
            Text("Aircraft Search")
                .font(titleFont)
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
                    if NFCTagReaderSession.readingAvailable{
                        ToolbarItem(placement: .bottomBar){
                            HStack{
                                Button(action:{
                                    NFCR.read()
                                }){
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
            }
            .searchable(text:$searchText)
            if NFCTagReaderSession.readingAvailable{
                Text(NFCR.hexID)
                Text("\(NFCR.intID)")
                Text(searchTagUID(NFCR.intID))
            }
        }
    }
    
    var filteredAircraft: [AircraftModel]{
        if searchText.isEmpty {
            return products
        }else{
            return products.filter{
                "\($0.tail_num) \($0.make) \($0.model)".contains(searchText)
            }
        }
    }
    
    func searchTagUID(_ uid: UInt64) -> String{
        let filteredProductList = products.filter{
            $0.nfc_uid == uid
        }
        if filteredProductList.count > 0{
            return filteredProductList[0].tail_num
        }else{
            return ""
        }
    }
}

#Preview {
    ScanView()
        .ignoresSafeArea()
}
