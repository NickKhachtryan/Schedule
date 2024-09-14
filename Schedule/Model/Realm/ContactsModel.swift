//
//  ContactsModel.swift
//  Schedule
//
//  Created by Nick Khachatryan on 14.09.2024.
//

import RealmSwift

class ContactsModel : Object {
    @Persisted var contactsName: String = ""
    @Persisted var contactsPhoneNumber: String = ""
    @Persisted var contactsEmail: String = ""
    @Persisted var contactsType: String = ""
    @Persisted var contactsImage: Data?
}

