//
//  AircraftInspector.swift
//  Fleet-Manager-SwiftUI
//
//  Created by Luke McGovern on 12/3/23.
//

import SwiftUI

struct AircraftInspector: View {
    let bodyFont = Font.body.lowercaseSmallCaps()
    var airplane: Aircraft

    var body: some View {
        VStack(alignment: .leading) { //
            // very messy should be in a loop
            List {
                HStack {
                    Text("Group ID")
                        .font(bodyFont)
                    Spacer()
                    Text("\(String(airplane.group_id))")
                        .font(bodyFont)
                }
                Spacer()
                HStack {
                    Text("Tail Number")
                        .font(bodyFont)
                    Spacer()
                    Text("\(airplane.tail_num)")
                        .font(bodyFont)
                }
                Spacer()
                HStack {
                    Text("NFC Chip UID")
                        .font(bodyFont)
                    Spacer()
                    Text("\(String(airplane.nfc_uid))")
                        .font(bodyFont)
                }
                Spacer()
                HStack {
                    Text("Make")
                        .font(bodyFont)
                    Spacer()
                    Text("\(airplane.make)")
                        .font(bodyFont)
                }
                Spacer()
                HStack {
                    Text("Model")
                        .font(bodyFont)
                    Spacer()
                    Text("\(airplane.model)")
                        .font(bodyFont)
                }
                Spacer()
            }
        }
    }
}
