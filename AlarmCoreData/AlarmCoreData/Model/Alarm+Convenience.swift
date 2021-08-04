//
//  Alarm+Convenience.swift
//  AlarmCoreData
//
//  Created by Andrew Saeyang on 7/29/21.
//

import CoreData

extension Alarm{
    
  @discardableResult
    convenience init(title: String, fireDate: Date, isEnabled: Bool, uuid: String = UUID().uuidString, context: NSManagedObjectContext = CoreDataStack.context){
       
        self.init(context:context)
        self.title = title
        self.fireDate = fireDate
        self.isEnabled = isEnabled
        self.uuid = uuid
               
        
    }
    
}
