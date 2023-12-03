//
//  LoginView.swift
//  Fleet-Manager-SwiftUI
//
//  Created by user246870 on 12/1/23.
//

import SwiftUI

struct RegisterView: View {
    let titleFont = Font.largeTitle.lowercaseSmallCaps()
    let bodyFont = Font.body.lowercaseSmallCaps()
    
    @State var username: String = ""
    @State var password: String = ""
    @State var repPassword: String = ""
    @State var groupID: String = ""
    
    var body: some View {
        VStack {
            Text("Welcome")
                .font(titleFont.monospaced())
                .fontWeight(.bold)
                .padding(.bottom, 42)
            VStack {
                InputFieldView(data: $username, title: "Username")
                InputFieldView(data: $password, title: "Password")
                InputFieldView(data: $repPassword, title: "Repeat Password")
                InputFieldView(data: $groupID, title: "Group ID")
            }.padding(.bottom, 16)
        }.padding()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
