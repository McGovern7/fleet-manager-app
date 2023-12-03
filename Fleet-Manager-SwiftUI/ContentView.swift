//
//  ContentView.swift
//  Fleet-Manager-SwiftUI
//
//  Created by Matt on 11/3/23.
//

import SwiftUI

struct URLImage: View {
    let imageName: String
    
    @State var data: Data?
    
    var body: some View {
        if imageName != "" {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 70)
                .background(Color.gray)
        }
        else {
            Image(systemName: "airplane")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 70)
                .background(Color.gray)
                .onAppear() {
                    fetchData()
                }
        }
        Image("")
    }
    private func fetchData() {
        guard let url = URL(string: "https://esmith87.w3.uvm.edu/aircraft/list") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        task.resume()
    }
}

struct ContentView: View {
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        
        switch selectedTab {
        case .home:
            HomeView()
        case .hangar:
            HangarView()
        case .scan:
            ScanView()
        }
        Spacer()
        CustomTabBar(selectedTab: $selectedTab)
    }
}

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
    }
}

struct HangarView: View {
    @StateObject var viewModel = ViewModel()
    @State private var navToPost : Bool = false
    let titleFont = Font.largeTitle.lowercaseSmallCaps()
    let bodyFont = Font.body.lowercaseSmallCaps()
    
    var body: some View {
        VStack {
            Text("Hangar")
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
            NavigationStack { // nav stack by group id
                List {
                    ForEach(viewModel.airplanes, id: \.self) { airplane in
                        NavigationLink(destination:
                                        VStack(alignment: .leading) {
                            // very messy should be in a loop
                            HStack {
                                Text("\tGroup ID")
                                    .font(bodyFont)
                                Spacer()
                                Text("\(airplane.group_id)\t")
                                    .font(bodyFont)
                            }
                            HStack {
                                Text("\tTail Number")
                                    .font(bodyFont)
                                Spacer()
                                Text("\(airplane.tail_num)\t")
                                    .font(bodyFont)
                            }
                            Spacer()
                            HStack {
                                Text("\tNFC Chip UID")
                                    .font(bodyFont)
                                Spacer()
                                Text("\(String(airplane.nfc_uid))\t")
                                    .font(bodyFont)
                            }
                            Spacer()
                            HStack {
                                Text("\tMake")
                                    .font(bodyFont)
                                Spacer()
                                Text("\(String(airplane.make))\t")
                                    .font(bodyFont)
                            }
                            Spacer()
                            HStack {
                                Text("\tModel")
                                    .font(bodyFont)
                                Spacer()
                                Text("\(String(airplane.model))\t")
                                    .font(bodyFont)
                            }
                            Spacer()
                        }
                        )  {
                            URLImage(imageName: String(airplane.image))
                            Text(airplane.tail_num)
                                .padding(3)
                        }
                    }
                }
                .navigationTitle("Airplanes")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            navToPost = true
                        } label: {
                            Image(systemName: "plus.app")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding()
                        }
                        .navigationDestination(isPresented: $navToPost) {
                            PostView() // move to PostView
                        }
                    }
                }
                .onAppear {
                    viewModel.fetch() // fetch all airplane list info
                }
            }
        }
    }
}

extension String {
    var isNumeric: Bool {
        Double(self) != nil // ensure that nfc_uid can be an integer before posting
    }
}

// view which handles user creation of new aircraft in POST call
struct PostView: View {
    @StateObject var viewModel = ViewModel()
    
    @State private var group_id = ""
    @State private var tail_num = ""
    @State private var nfc_uid = ""
    @State private var make = ""
    @State private var model = ""
    @State private var image = ""
    // image = model
    var isFormValid: Bool {
        !group_id.isEmpty && !tail_num.isEmpty && !nfc_uid.isEmpty && !make.isEmpty && !model.isEmpty && nfc_uid.isNumeric && group_id.isNumeric
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Aircraft Information")) {
                    TextField("Tail Number", text: $tail_num)
                    TextField("NFC UID", text: $nfc_uid)
                    TextField("Make of Aircraft", text: $make)
                    TextField("Model of Aircraft", text: $model)
                    Button("Save") {
                        viewModel.makePOSTRequest()
                    }.disabled(!isFormValid) // disabled while form is not valid
                }
            }
            .navigationTitle("Add Aircraft")
        }
    }
}

#Preview {
    ContentView()
}
