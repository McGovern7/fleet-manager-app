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
    var body: some View {
        Text("Home")
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
          .ignoresSafeArea()
    }
}

struct HangarView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        Text("My Hangar")
            .font(.largeTitle)
            .padding(20)
            .padding(.top, 50)
            .frame(
                maxWidth: .infinity,
                alignment: .center
              )
        NavigationView {
            List {
                ForEach(viewModel.airplanes, id: \.self) { airplane in
                    HStack {
//                        URLImage(urlString: airplane.maintenance_log_id)
                        
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

struct ScanView: View {
    var body: some View {
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
          .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
