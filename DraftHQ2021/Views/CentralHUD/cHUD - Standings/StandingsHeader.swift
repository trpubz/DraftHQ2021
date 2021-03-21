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
                SortableColumn(cat: .OVR, sortColumn: $sortedColumn, sortStyle: $sortedStyle)
            }
            Divider()
            HStack(spacing: 0) {
                SortableColumn(cat: .HIT, sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(cat: .HR, sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(cat: .R, sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(cat: .RBI, sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(cat: .NSB, sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(cat: .OBP, sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(cat: .SLG, sortColumn: $sortedColumn, sortStyle: $sortedStyle)
            }
            Divider()
            HStack(spacing: 0) {
                SortableColumn(cat: .PIT, sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(cat: .IP, sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(cat: .QS, sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(cat: .SVHD, sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(cat: .ERA, sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(cat: .WHIP, sortColumn: $sortedColumn, sortStyle: $sortedStyle)
                SortableColumn(cat: .Kp9, sortColumn: $sortedColumn, sortStyle: $sortedStyle)
            }
        }
    }
}

struct SortableColumn: View {
    var cat: Categories
    @Binding var sortColumn: SortColumn
    @Binding var sortStyle: SortStyle
    
    var body: some View {
        HStack(spacing: 0.3) {
            Text(cat.rawValue)
                .foregroundColor(self.cat.rawValue == sortColumn.rawValue ? .altRed : .primary)
                .fontWeight(colCheck(cat: self.cat) ? .bold : .regular)
                .frame(width: 37)
            if sortColumn.rawValue == cat.rawValue {
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
            if self.sortColumn != SortColumn(rawValue: self.cat.rawValue)! {
                self.sortStyle = .desc
                self.sortColumn = SortColumn(rawValue: self.cat.rawValue)!
            } else if self.sortColumn == SortColumn(rawValue: self.cat.rawValue)! {
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
    
    func colCheck(cat: Categories) -> Bool {
        switch cat {
        case .OVR, .HIT, .PIT:
            return true
        default:
            return false
        }
    }
}

struct StandingsHeader_Previews: PreviewProvider {
    static var previews: some View {
        StandingsHeader(sortedColumn: .constant(.OVR), sortedStyle: .constant(.desc))
    }
}
