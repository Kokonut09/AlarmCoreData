//
//  AlarmController.swift
//  AlarmCoreData
//
//  Created by Andrew Saeyang on 7/29/21.
//

import CoreData

class AlarmController: AlarmScheduler{
    
    static let shared = AlarmController()
    
    // MARK: - PROPERTIES
    var alarms: [Alarm] = []
    
    private lazy var fetchRequest: NSFetchRequest<Alarm> = {
        
        let request = NSFetchRequest<Alarm>(entityName: "Alarm")
        request.predicate = NSPredicate(value: true)
        return request
        
    }()
    func fetchAlarmss(){
        self.alarms = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    // MARK: - CRUD
    func createAlarm(withTitle title: String,on isEnabled: Bool, and fireDate: Date){
        let newAlarm = Alarm(title: title, fireDate: fireDate, isEnabled: isEnabled)
        
        alarms.append(newAlarm)
        
        if isEnabled{
            scheduleUserNotifications(for: newAlarm)
        }
        
        
        CoreDataStack.saveContext()
    }
    
    func update(alarm: Alarm, newTitle: String, newFireDate: Date, isEnabled: Bool){
        alarm.title = newTitle
        alarm.fireDate = newFireDate
        alarm.isEnabled = isEnabled
        
        if isEnabled{
            scheduleUserNotifications(for: alarm)
        }
        
        
        CoreDataStack.saveContext()
    }
    
    func toggleIsEnabledFor(alarm: Alarm){
        alarm.isEnabled.toggle()
        
        alarm.isEnabled ? scheduleUserNotifications(for: alarm) : cancelUserNotifications(for: alarm)
        CoreDataStack.saveContext()
    }
    
    func delete(alarm: Alarm){
        guard let index = alarms.firstIndex(of: alarm) else { return }
        alarms.remove(at: index)
        
        cancelUserNotifications(for: alarm)
        
        CoreDataStack.context.delete(alarm)
        CoreDataStack.saveContext()
        
    }

  
}
