//
//  ScanView.swift
//  Fleet-Manager-SwiftUI
//
//  Created by Eli Smith on 11/24/23.
//

import SwiftUI

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
                    ForEach(filteredAircraft, id: \.self){ item in
                        Text("\(item)")
                    }
                }
                .toolbar{
                    ToolbarItem(placement: .bottomBar){
                        HStack{
                            Button(action:{}){
                                Image(systemName:"sensor.tag.radiowaves.forward")
                                    .font(.title)
                                    .foregroundColor(.accentColor)
                                Text("Scan")
                                    .foregroundColor(.accentColor)
                                
                            }
                            .fontWeight(.bold)
                            .padding(10)
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
    
    var filteredAircraft: [String]{
        if searchText.isEmpty {
            return ["All"]
        }else{
            return ["Filtered"]
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
