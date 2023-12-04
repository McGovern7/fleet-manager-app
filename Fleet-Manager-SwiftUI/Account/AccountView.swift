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
    
    @StateObject var viewModel = ViewModel()

    @State var loginView: Bool = true
    @State var username: String = ""
    @State var password: String = ""
    @State var passRepeat: String = ""
    @State var groupID: String = ""
    @State var intGroupID: Int = 0
    
    var body: some View {
        VStack {
            if loginView {
                LoginView(username: $username, password: $password)
            } else {
                RegisterView(username: $username, password: $password, repPassword: $passRepeat, groupID: $groupID)
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
                    if !loginView {
                        intGroupID = Int(groupID) ?? 0
                        var post_request: [String : AnyHashable] = acctPostRequest(username: username, password: password, groupID: intGroupID)
                        viewModel.userPOSTRequest(postRequest: post_request)
                    }
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

func acctPostRequest(username: String, password: String, groupID: Int) -> Dictionary<String, AnyHashable> {
    var postRequest: [String : AnyHashable] = [:]
    postRequest["username"] = username
    postRequest["password"] = password
    postRequest["group_id"] = groupID
    
    return postRequest
}

#Preview {
    AccountView()
}
