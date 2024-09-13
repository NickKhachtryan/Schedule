//
//  ScheduleModel.swift
//  Schedule
//
//  Created by Nick Khachatryan on 19.08.2024.
//

import RealmSwift

class ScheduleModel: Object {
    @Persisted var scheduleDate : Date?
    @Persisted var scheduleTime : Date?
    @Persisted var scheduleName: String = ""
    @Persisted var scheduleType: String = ""
    @Persisted var scheduleBuilding: String = ""
    @Persisted var scheduleAudience: String = ""
    @Persisted var scheduleTeacher: String = "Name Lastname"
    @Persisted var scheduleColor: String = "FF443B"
    @Persisted var scheduleRepeat: Bool = true
    @Persisted var scheduleWeekday: Int = 1
}
