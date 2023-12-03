//
//  AccountView.swift
//  Fleet-Manager-SwiftUI
//
//  Created by user246870 on 12/3/23.
//

import SwiftUI

enum AcctView {
    case login, register
}

struct AccountView: View {
    let bodyFont = Font.body.lowercaseSmallCaps()

    @State var loginView: Bool = true
    
    var body: some View {
        VStack {
            if loginView {
                LoginView()
            } else {
                RegisterView()
            }
            VStack {
                Button(action: {/* SQL Post here */}) {
                    Text(loginView ? "Login" : "Register")
                        .font(bodyFont)
                        .fontWeight(.heavy)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(red: 56/255, green: 223/255, blue: 223/255))
                        .cornerRadius(40)
                }
                Button(action: {
                    loginView.toggle()
                }) {
                    Text(loginView ? "Register" : "Login")
                        .font(bodyFont)
                        .fontWeight(.heavy)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(red: 56/255, green: 223/255, blue: 223/255))
                        .cornerRadius(40)
                }
            }.padding([.leading, .trailing])
        }
    }
}

#Preview {
    AccountView()
}
