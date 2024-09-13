//
//  TaskModel.swift
//  Schedule
//
//  Created by Nick Khachatryan on 10.09.2024.
//

import RealmSwift

class TaskModel: Object {
    @Persisted var taskDate : Date?
    @Persisted var taskName: String = ""
    @Persisted var taskDescription: String = ""
    @Persisted var taskColor: String = "FF443B"
    @Persisted var taskReady: Bool = false
}
