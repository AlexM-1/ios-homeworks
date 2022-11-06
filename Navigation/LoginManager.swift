//
//  LoginManager.swift
//  Navigation
//
//  Created by Alex M on 19.10.2022.
//

import Foundation
import RealmSwift


class UserLoginData: Object {

    @Persisted var login = ""
    @Persisted var pswd = ""

    func changePassword(newPassword: String) {
        let realm = try! Realm()
        try! realm.write {
            pswd = newPassword
        }
    }

    func renameUser(newName: String) {
        let realm = try! Realm()
        try! realm.write {
            login = newName
        }
    }

}


class LoginManager {
    static let `default` = LoginManager()

    init() {
        migrate()
        refreshDatabase()
    }

    var users: [UserLoginData] = []


    private func refreshDatabase() {
        let realm = try! Realm()
        users = Array(realm.objects(UserLoginData.self))
    }


    func addUser(login: String, pswd: String) {
        let realm = try! Realm()
        try! realm.write {
            let user = UserLoginData()
            user.login = login
            user.pswd = pswd
            realm.add(user)
        }
        refreshDatabase()
    }

    func deleteUser(user: UserLoginData) {
        let realm = try! Realm()
        try! realm.write{
            realm.delete(user)
        }
        refreshDatabase()
    }


    private func migrate() {
        let config = Realm.Configuration(schemaVersion: 3)
        Realm.Configuration.defaultConfiguration = config
    }

}

