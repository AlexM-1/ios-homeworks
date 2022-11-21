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
        do {
            let realm = try Realm()
            try realm.write {
                pswd = newPassword
            }
        } catch  let error as NSError {
            fatalError("Error while changePassword: \(error.localizedDescription)")
        }
    }

    func renameUser(newName: String) {
        do {
            let realm = try Realm()
            try realm.write {
                login = newName
            }
        }
        catch let error as NSError {
            fatalError("Error while renameUser: \(error.localizedDescription)")
        }
    }
}


class LoginManager {

    static let `default` = LoginManager()

    init() {
        configRealm()
        refreshDatabase()
    }

    var users: [UserLoginData] = []

    private func refreshDatabase() {

        do {
            let realm = try Realm()
            users = Array(realm.objects(UserLoginData.self))

        } catch let error as NSError {
            fatalError("Error opening realm: \(error.localizedDescription)")
        }
    }


    func addUser(login: String, pswd: String) {

        do {
            let realm = try Realm()
            try realm.write {
                let user = UserLoginData()
                user.login = login
                user.pswd = pswd
                realm.add(user)
            }
            refreshDatabase()
        } catch let error as NSError {
            fatalError("Error while addUser: \(error.localizedDescription)")
        }
    }


    func deleteUser(user: UserLoginData) {
        do {
            let realm = try Realm()
            try realm.write{
                realm.delete(user)
            }
            refreshDatabase() }
        catch let error as NSError {
            fatalError("Error while deleteUser: \(error.localizedDescription)")
        }
    }


    private func configRealm() {
        let config = Realm.Configuration(encryptionKey: getKey())
        Realm.Configuration.defaultConfiguration = config
    }






    private func getKey() -> Data {

        // Identifier for our keychain entry - should be unique for your application
        let keychainIdentifier = "io.Realm.EncryptionExampleKey"
        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!

        // First check in the keychain for an existing key
        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]

        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            return dataTypeRef as! Data
        }

        // No pre-existing key from this application, so generate a new one
        // Generate a random encryption key
        var key = Data(count: 64)
        key.withUnsafeMutableBytes({ (pointer: UnsafeMutableRawBufferPointer) in
            let result = SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
            assert(result == 0, "Failed to get random bytes")
        })

        // Store the key in the keychain
        query = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecValueData: key as AnyObject
        ]
        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
        return key
    }



}

