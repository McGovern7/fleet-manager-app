//
//  HomeView.swift
//  Fleet-Manager-SwiftUI
//
//  Created by user246870 on 12/3/23.
//

import SwiftUI

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
        Spacer()
        AccountView().ignoresSafeArea()
        Spacer()
    }
}

#Preview {
    HomeView()
}
