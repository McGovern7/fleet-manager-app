//
//  AccountView.swift
//  Fleet-Manager-SwiftUI
//
//  Created by user246870 on 12/3/23.
//

import SwiftUI
import CryptoKit

enum AcctView {
    case login, register
}

struct AccountView: View {
    let titleFont = Font.largeTitle.lowercaseSmallCaps()
    let bodyFont = Font.body.lowercaseSmallCaps()
    
    @StateObject var viewModel = ViewModel()

    @Binding var signedIn: Bool
    @State var loginView: Bool = true
    @Binding var username: String
    @State var password: String = ""
    @State var passRepeat: String = ""
    @Binding var groupID: String
    @State var intGroupID: Int = 0
    
    var body: some View {
        if signedIn {
            Text("Welcome " + username)
                .font(titleFont.monospaced())
                .fontWeight(.bold)
                .padding(.bottom, 42)
        } else {
            VStack {
                if loginView {
                    LoginView(username: $username, password: $password)
                } else {
                    RegisterView(username: $username, password: $password, repPassword: $passRepeat, groupID: $groupID)
                        .ignoresSafeArea()
                }
                VStack {
                    Button(action: {
                        if loginView {
                            let hashedPass = encryptPassword(password: password)
                            for user in viewModel.users {
                                if user.name == username {
                                    if user.password == hashedPass {
                                        signedIn = true
                                    }
                                }
                            }
                        } else {
                            if password == passRepeat {
                                let hashedPass = encryptPassword(password: password)
                                intGroupID = Int(groupID) ?? 0
                                var post_request: [String : AnyHashable] = acctPostRequest(username: username, password: hashedPass, groupID: intGroupID)
                                viewModel.userPOSTRequest(postRequest: post_request)
                            }
                        }
                    }) {
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
                        username = ""
                        password = ""
                        passRepeat = ""
                        groupID = ""
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
}

func acctPostRequest(username: String, password: String, groupID: Int) -> Dictionary<String, AnyHashable> {
    var postRequest: [String : AnyHashable] = [:]
    postRequest["name"] = username
    postRequest["password"] = password
    postRequest["group_id"] = groupID
    
    return postRequest
}

func encryptPassword(password: String) -> String {
    let salt = "flyingiscool"
    let saltedPassword = password + salt

    guard let saltedPasswordData = saltedPassword.data(using: .utf8) else {
        return ""
    }

    let hashedPassword = SHA256.hash(data: saltedPasswordData)
    let hashedPasswordString = hashedPassword.compactMap { String(format: "%02x", $0) }.joined()

    return hashedPasswordString
}

struct AccountView_Previews: PreviewProvider {
    @State static var signedIn: Bool = false
    @State static var username: String = ""
    @State static var groupID: String = ""
    
    static var previews: some View {
        AccountView(signedIn: $signedIn, username: $username, groupID: $groupID)
    }
}
