//
//  HomeView.swift
//  Fleet-Manager
//
//  Created by Matt Gaetano on 11/3/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack() {
            Text("Home")
                .font(.largeTitle)
                .padding(20)
            Spacer()
            HStack(spacing: 40) {
                Button("Home") {
                    
                }
                Button("My Hangar") {
                    
                }
                Button("Plane") {
                    
                }
                Button("Scan") {
                    
                }
            }
        }
    }
}

struct HangarView: View {
    var body: some View {
        VStack() {
            Text("Home")
                .font(.largeTitle)
                .padding(20)
            Spacer()
            HStack(spacing: 40) {
                Button("Home") {
                    
                }
                Button("My Hangar") {
                    
                }
                Button("Plane") {
                    
                }
                Button("Scan") {
                    
                }
            }
        }
    }
}

struct PlaneView: View {
    var body: some View {
        VStack() {
            Text("Aircraft Name")
                .font(.largeTitle)
                .padding(20)
            Spacer()
            HStack(spacing: 40) {
                Button("Home") {
                    
                }
                Button("My Hangar") {
                    
                }
                Button("Plane") {
                    
                }
                Button("Scan") {
                    
                }
            }
        }
    }
}

struct ScanView: View {
    var body: some View {
        VStack() {
            Text("Aircraft Search")
                .font(.largeTitle)
                .padding(20)
            Spacer()
            HStack(spacing: 40) {
                Button("Home") {
                    
                }
                Button("My Hangar") {
                    
                }
                Button("Plane") {
                    
                }
                Button("Scan") {
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        HangarView()
    }
}
