//
//  DateExtension.swift
//  AlarmCoreData
//
//  Created by Andrew Saeyang on 7/29/21.
//

import Foundation
extension Date {
    
    func dateAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        
        return formatter.string(from: self)
        
    }
}
