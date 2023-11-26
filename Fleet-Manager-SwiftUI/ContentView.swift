//
//  ContentView.swift
//  Fleet-Manager-SwiftUI
//
//  Created by Matt on 11/3/23.
//

import SwiftUI

enum Screen {
    case home, hangar, scan
}

struct ContentView: View {
    @State var currScreen = Screen.home
    var body: some View {
        VStack {
            switch currScreen {
            case .home:
                HomeView()
            case .hangar:
                HangarView()
            case .scan:
                ScanView()
            }
            Spacer()
            NavTab(currScreen: $currScreen)
        }
        .ignoresSafeArea()
    }
}

struct NavTab: View {
    @Binding var currScreen: Screen
    var body: some View {
        HStack(spacing: 50) {
            Button() {
                currScreen = Screen.home
            } label: {
                Image(systemName: "house.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor({
                        if currScreen == Screen.home {
                            .blue
                        } else {
                            .gray
                        }
                    }())
            }
            Button() {
                currScreen = Screen.hangar
            } label: {
                Image(systemName: "airplane.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor({
                        if currScreen == Screen.hangar {
                            .blue
                        } else {
                            .gray
                        }
                    }())            }
            Button() {
                currScreen = Screen.scan
            } label: {
                Image(systemName: "magnifyingglass.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor({
                        if currScreen == Screen.scan {
                            .blue
                        } else {
                            .gray
                        }
                    }())
            }
        }
        .padding(.horizontal, 30)
        .padding(.top, 20)
        .padding(.bottom, 50)
        .frame(
              maxWidth: .infinity,
              alignment: .center
            )
        .background(Color(red: 85/255, green: 214/255, blue: 175/255)
            .ignoresSafeArea())
        .clipShape(
            .rect(
                topLeadingRadius: 30,
                topTrailingRadius: 30
            )
        )
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
    }
}

struct HangarView: View {
    var body: some View {
        Text("My Hangar")
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
