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
    
    @Binding var username: String
    @Binding var password: String
    @Binding var repPassword: String
    @Binding var groupID: String
    
    var body: some View {
        VStack {
            Text("Welcome")
                .font(titleFont.monospaced())
                .fontWeight(.bold)
                .padding(.bottom, 42)
            VStack {
                InputFieldView(data: $username, title: "Username", isSecure: false)
                InputFieldView(data: $password, title: "Password", isSecure: true)
                InputFieldView(data: $repPassword, title: "Repeat Password", isSecure: true)
                InputFieldView(data: $groupID, title: "Group ID", isSecure: false)
            }.padding(.bottom, 16)
        }.padding()
    }
}

struct RegisterView_Previews: PreviewProvider {
    @State static var username: String = ""
    @State static var password: String = ""
    @State static var passRepeat: String = ""
    @State static var groupID: String = ""
    
    static var previews: some View {
        RegisterView(username: $username, password: $password, repPassword: $passRepeat, groupID: $groupID)
    }
}
