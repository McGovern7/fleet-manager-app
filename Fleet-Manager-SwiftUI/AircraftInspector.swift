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
            HStack {
                Text("\tGroup ID")
                    .font(bodyFont)
                Spacer()
                Text("\(String(airplane.group_id)) \t")
                    .font(bodyFont)
            }
            Spacer()
            HStack {
                Text("\tTail Number")
                    .font(bodyFont)
                Spacer()
                Text("\(airplane.tail_num) \t")
                    .font(bodyFont)
            }
            Spacer()
            HStack {
                Text("\tNFC Chip UID")
                    .font(bodyFont)
                Spacer()
                Text("\(String(airplane.nfc_uid)) \t")
                    .font(bodyFont)
            }
            Spacer()
            HStack {
                Text("\tMake")
                    .font(bodyFont)
                Spacer()
                Text("\(airplane.make) \t")
                    .font(bodyFont)
            }
            Spacer()
            HStack {
                Text("\tModel")
                    .font(bodyFont)
                Spacer()
                Text("\(airplane.model) \t")
                    .font(bodyFont)
            }
            Spacer()
        }
    }
}
