//
//  ScanView.swift
//  Fleet-Manager-SwiftUI
//
//  Created by Eli Smith on 11/24/23.
//

import SwiftUI
import CoreNFC

// Try to decode JSON data with the expectation that it conforms to a structure.
// In this case, the structure is an array of AircraftModel structs, which the
// example JSON string conforms to.
let decoder = JSONDecoder()

struct ScanView: View {
    
    @ObservedObject var NFCR = MiFareReader()
    
    @State private var searchText = ""
    @State private var navPath: [Aircraft] = []
    
    let products = AircraftGetter.getCollection()
    
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
            NavigationStack(path: $navPath){
                List{
                    ForEach(filteredAircraft, id: \.self.tail_num){ item in
                        NavigationLink(value: item){
                            VStack(alignment: .leading){
                                Text("\(item.tail_num)")
                                    .font(.headline)
                                Text("\(item.make) \(item.model)")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .navigationDestination(for: Aircraft.self) { aircraft in
                    AircraftInspector(airplane: aircraft)
                }
                .onChange(of: NFCR.intID){ intID in
                    if let aircraft = searchTagUID(intID){
                        navPath.append(aircraft)
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
        }
    }
    
    var filteredAircraft: [Aircraft]{
        if searchText.isEmpty {
            return products
        }else{
            return products.filter{
                "\($0.tail_num) \($0.make) \($0.model)".contains(searchText)
            }
        }
    }
    
    func searchTagUID(_ uid: UInt64) -> Aircraft?{
        let filteredProductList = products.filter{
            $0.nfc_uid == uid
        }
        if filteredProductList.count > 0{
            return filteredProductList[0]
        }else{
            return nil
        }
    }
}

#Preview {
    ScanView()
        .ignoresSafeArea()
}
