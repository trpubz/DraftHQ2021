//
//  Functions.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 5/14/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import Foundation

//when the stat is an Int
public func rankings(_ highToLow: Array<(key: String, value: Int)>) -> [String:Int] {
    var rankings = [String:Int]()
    var rnk: Double = 1.0
    for i in 0...highToLow.count - 2 {
        if highToLow[i].value > highToLow[i + 1].value {
            rankings[highToLow[i].key] = Int(rnk)
            rnk += 1.0
        } else if highToLow[i].value == highToLow[i + 1].value && rankings[highToLow[i].key] == nil {
            let samsies = highToLow.filter({$0.value == highToLow[i].value}) //number of teams with the same category total
            var sharedRnk: Double = rnk
            for x in (Int(rnk)+1)...(Int(rnk)+samsies.count-1) {
                sharedRnk += Double(x)
            }
            sharedRnk /= Double(samsies.count)
            for tm in samsies {
                rankings[tm.key] = Int(sharedRnk)
            }
            rnk += Double(samsies.count)
        } else if i == highToLow.count - 2 && rankings[highToLow[i + 1].key] == nil { //last testable index
            rankings[highToLow[i + 1].key] = Int(rnk)
        }
    }
    return rankings
}

public func big3Rankings(_ highToLow: Array<(key: String, value: Int)>) -> [String:Int] {
    var rankings = [String:Int]()
    var rnk: Double = 1.0
    for i in 0...highToLow.count - 2 {
        if highToLow[i].value < highToLow[i + 1].value {
            rankings[highToLow[i].key] = Int(rnk)
            rnk += 1.0
        } else if highToLow[i].value == highToLow[i + 1].value && rankings[highToLow[i].key] == nil {
            let samsies = highToLow.filter({$0.value == highToLow[i].value}) //number of teams with the same category total
            var sharedRnk: Double = rnk
            for x in (Int(rnk)+1)...(Int(rnk)+samsies.count-1) {
                sharedRnk += Double(x)
            }
            sharedRnk /= Double(samsies.count)
            for tm in samsies {
                rankings[tm.key] = Int(sharedRnk)
            }
            rnk += Double(samsies.count)
        } else if i == highToLow.count - 2 && rankings[highToLow[i + 1].key] == nil { //last testable index
            rankings[highToLow[i + 1].key] = Int(rnk)
        }
    }
    return rankings
}
