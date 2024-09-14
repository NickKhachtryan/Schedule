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
    
}
