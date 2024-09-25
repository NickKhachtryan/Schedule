//
//  RealmManager.swift
//  Schedule
//
//  Created by Nick Khachatryan on 19.08.2024.
//

import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    private init(){}
    let localRealm = try! Realm()
    
    func saveScheduleModel(model: ScheduleModel){
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func saveTaskModel(model: TaskModel){
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteTaskModel(model: TaskModel){
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    func updateReadyButtonTaskModel (task: TaskModel, bool: Bool){
        try! localRealm.write {
            task.taskReady = bool
        }
    }
    
    func deleteScheduleModel(model: ScheduleModel){
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    func saveContactsModel(model: ContactsModel){
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteContactsModel(model: ContactsModel){
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    func editContactsModel(model: ContactsModel, nameArray: [String], imageData: Data?) {
        try! localRealm.write {
            model.contactsName = nameArray[0]
            model.contactsPhoneNumber = nameArray[1]
            model.contactsEmail = nameArray[2]
            model.contactsType = nameArray[3]
            model.contactsImage = imageData
            
        }
    }
    
    func editScheduleModel(model: ScheduleModel, nameArray: [[String]], bool: Bool, date: Date?, time: Date?, numberWeekday: Int, cellColor: String) {
        do {
            try localRealm.write {
                if let newDate = date {
                    model.scheduleDate = newDate
                }

                if let newTime = time {
                    model.scheduleTime = newTime
                }

                model.scheduleName = nameArray[1][0]
                model.scheduleType = nameArray[1][1]
                model.scheduleBuilding = nameArray[1][2]
                model.scheduleAudience = nameArray[1][3]
                model.scheduleTeacher = nameArray[2][0]
                model.scheduleColor = cellColor
                model.scheduleRepeat = bool
                model.scheduleWeekday = numberWeekday
            }
        } catch {
            print("Error editing schedule model: \(error)")
        }
    }

    
}
