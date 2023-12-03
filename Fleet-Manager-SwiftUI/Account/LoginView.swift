//
//  LoginView.swift
//  Fleet-Manager-SwiftUI
//
//  Created by user246870 on 12/1/23.
//

import SwiftUI

struct LoginView: View {
    let titleFont = Font.largeTitle.lowercaseSmallCaps()
    let bodyFont = Font.body.lowercaseSmallCaps()
    
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            Text("Welcome")
                .font(titleFont.monospaced())
                .fontWeight(.bold)
                .padding(.bottom, 42)
            VStack {
                InputFieldView(data: $username, title: "Username")
                InputFieldView(data: $password, title: "Password")
            }.padding(.bottom, 16)
            HStack {
                Spacer()
                Button(action: {}) {
                    Text("Forgot Password?")
                        .fontWeight(.thin)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .underline()
                }
            }.padding(.bottom, 16)
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
