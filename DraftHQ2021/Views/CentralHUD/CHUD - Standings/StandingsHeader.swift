//
//  StandingsHeader.swift
//  DraftHQ2021
//
//  Created by TP on 6/5/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI

struct StandingsHeader: View {
    @Binding var sortedColumn: SortColumn
    @Binding var sortedStyle: SortStyle
    
    var body: some View {
        HStack(spacing: 0) {
            HStack {
                TeamText(tm: "TEAM")
                ProjRecText(projRec: "Proj Record")
                SortableColumn(description: "OVR", sortColumn: $sortedColumn, sortStyle: $sortedStyle)
            }
            HStack(spacing: 0) {
                SortableColumn(description: "HIT", sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(description: "HR", sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(description: "R", sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(description: "RBI", sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(description: "NSB", sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(description: "OBP", sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(description: "SLG", sortColumn: $sortedColumn, sortStyle: $sortedStyle)
            }
            HStack(spacing: 0) {
                SortableColumn(description: "PIT", sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(description: "IP", sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(description: "QS", sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(description: "SVHD", sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(description: "ERA", sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(description: "WHIP", sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(description: "K/9", sortColumn: $sortedColumn, sortStyle: $sortedStyle)
            }
        }
    }
}

struct SortableColumn: View {
    var description: String
    @Binding var sortColumn: SortColumn
    @Binding var sortStyle: SortStyle
    
    var body: some View {
        HStack(spacing: 0.3) {
            Text(description)
                .foregroundColor(self.description == sortColumn.rawValue ? .altRed : .primary)
                .frame(width: 37)
            if sortColumn.rawValue == description {
                if self.sortStyle == .desc {
                    Image("chevronExpanded")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 16)
                }
                if self.sortStyle == .asc {
                    Image("chevronHover")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 16)
                }
            } else {
                Spacer()
            }
        }
        .frame(width: 55) //StatText view needs to match this width
        .onTapGesture {
            if self.sortColumn != SortColumn(rawValue: self.description)! {
                self.sortStyle = .desc
                self.sortColumn = SortColumn(rawValue: self.description)!
            } else if self.sortColumn == SortColumn(rawValue: self.description)! {
                switch self.sortStyle {
                case .none: self.sortStyle = .desc
                case .desc: self.sortStyle = .asc
                case .asc:
                    self.sortStyle = .none
                    self.sortColumn = .none
                }
            }
//            print(self.description + " container tapped. Sort style: \(self.sortStyle). Sort column: \(self.sortColumn)")
        }
    }
}

struct StandingsHeader_Previews: PreviewProvider {
    static var previews: some View {
        StandingsHeader(sortedColumn: .constant(.OVR), sortedStyle: .constant(.desc))
    }
}
