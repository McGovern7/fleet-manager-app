//
//  ContentView.swift
//  Fleet-Manager-SwiftUI
//
//  Created by Matt on 11/3/23.
//

import SwiftUI

struct URLImage: View {
    let urlString: String
    
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 70)
                .background(Color.gray)
        }
        else {
            Image(systemName: "airplane")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 70)
                .background(Color.gray)
                .onAppear() {
                    fetchData()
                }
        }
        Image("")
    }
    private func fetchData() {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        task.resume()
    }
}

struct ContentView: View {
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        
        switch selectedTab {
        case .home:
            HomeView()
        case .hangar:
            HangarView()
        case .scan:
            ScanView()
        }
        Spacer()
        CustomTabBar(selectedTab: $selectedTab)
    }
}

struct HomeView: View {
    let titleFont = Font.largeTitle.lowercaseSmallCaps()
    
    var body: some View {
        Text("Home")
            .font(titleFont.monospaced())
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
            .ignoresSafeArea()
    }
}

struct HangarView: View {
    @StateObject var viewModel = ViewModel()
    let titleFont = Font.largeTitle.lowercaseSmallCaps()
    let bodyFont = Font.body.lowercaseSmallCaps()
    
    
    var body: some View {
        Text("Hangar")
            .font(titleFont.monospaced())
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
            .ignoresSafeArea()
        NavigationView {
            List {
                ForEach(viewModel.airplanes, id: \.self) { airplane in
                    NavigationLink(destination:
                        VStack(alignment: .leading) {
                            Text("Tail Number: \(airplane.tail_num)")
                                .font(bodyFont)
                                .ignoresSafeArea()
                            Text("NFC Chip UID: \(String(airplane.nfc_uid))")
                                .font(bodyFont)
                                .ignoresSafeArea()
                            Text("Make: \(airplane.make)")
                                .font(bodyFont)
                                .ignoresSafeArea()
                            Text("Model: \(airplane.model)")
                                .font(bodyFont)
                                .ignoresSafeArea()
                            Text("Maintenance Log ID: \(airplane.maintenance_log_id)")
                                .font(bodyFont)
                                .ignoresSafeArea()
                        }
                    )  {
                        URLImage(urlString: String(airplane.make))
                        Text(airplane.tail_num)
                            .padding(3)
                    }
                }
            }
            .navigationTitle("Airplanes")
            .onAppear {
                viewModel.fetch()
            }
        }
    }
}

#Preview {
    ContentView()
}
