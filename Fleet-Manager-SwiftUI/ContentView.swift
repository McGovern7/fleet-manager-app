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
                        NavigationLink(destination: AircraftInspector(airplane: airplane)  )  {
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
    
    @State private var int_group_id = 0
    @State private var int_nfc_uid = 0
    // image = model
    var isFormValid: Bool {
        !group_id.isEmpty && !tail_num.isEmpty && !nfc_uid.isEmpty && !make.isEmpty && !model.isEmpty && nfc_uid.isNumeric && group_id.isNumeric
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Aircraft Information")) {
                    TextField("Group ID", text: $group_id)
                    TextField("Tail Number", text: $tail_num)
                    TextField("NFC UID", text: $nfc_uid)
                    TextField("Make of Aircraft", text: $make)
                    TextField("Model of Aircraft", text: $model)
                    Button("Save") {
                        image = model
                        int_group_id = Int(group_id) ?? 0
                        int_nfc_uid = Int(nfc_uid) ?? 0
                        var post_request: [String : AnyHashable] = createPostRequest(grp_id: int_group_id, tail_num: tail_num, nfc_uid: int_nfc_uid, make: make, model: model, img: image)
                        viewModel.makePOSTRequest(postRequest: post_request)
                    }.disabled(!isFormValid) // disabled while form is not valid
                }
            }
            .navigationTitle("Add Aircraft")
        }
    }
}

func createPostRequest(grp_id: Int, tail_num: String, nfc_uid: Int, make: String, model: String, img: String) -> Dictionary<String, AnyHashable> {
    var postRequest: [String : AnyHashable] = [:]
    postRequest["group_id"] = grp_id
    postRequest["tail_num"] = tail_num
    postRequest["nfc_uid"] = nfc_uid
    postRequest["make"] = make
    postRequest["model"] = model
    postRequest["image"] = img

    return postRequest
}


#Preview {
    ContentView()
}
