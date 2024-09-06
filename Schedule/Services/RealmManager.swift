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
}
