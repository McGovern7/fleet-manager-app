//
//  CustomTabBar.swift
//  Fleet-Manager
//
//  Created by Luke McGovern on 11/12/23.
//

import SwiftUI

// holds the values of the tabs
enum Tab: String, CaseIterable {
    case home = "house.circle"
    case hangar = "airplane.circle"
    case scan = "magnifyingglass.circle"
    func iconName() -> String {
        switch self {
            case .home:
                return "Home"
            case .hangar:
                return "Hangar"
            case .scan:
                return "Scan"
        }
    }
}

struct CustomTabBar: View {
    
    @Binding var selectedTab: Tab
    
    // function fills the image of the icon when it is the current tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    VStack {
                        Image(systemName: selectedTab == tab ? fillImage: tab.rawValue)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(selectedTab == tab ? .purple: .gray)
                            .font(.system(size: 22))
                            .onTapGesture{
                                withAnimation(.easeIn(duration: 0.1)) {
                                    selectedTab = tab
                                }
                            }
                    }
                }
            }
            .padding([.bottom, .leading, .trailing], 30)
            .frame(maxWidth: .infinity)
            .frame(height: 180)
            .background(Color(red: 85/255, green: 214/255, blue: 175/255))
            .clipShape(
                .rect(
                    topLeadingRadius: 30,
                    topTrailingRadius: 30
                )
            )
        }
    }
}


struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.home))
    }
}
