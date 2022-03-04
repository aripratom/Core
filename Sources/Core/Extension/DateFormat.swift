//
//  File.swift
//  
//
//  Created by Aria Pratomo on 01/03/22.
//

import Foundation

public struct DateFormat
{
    static func convertDateFormat(inputDate: String) -> String {
         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd"
         let oldDate = olDateFormatter.date(from: inputDate)
         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "dd MMM yyyy"
         return convertDateFormatter.string(from: oldDate!)
    }
}
