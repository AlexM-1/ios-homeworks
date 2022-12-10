//
//  CheckerService.swift
//  Navigation
//
//  Created by Alex M on 09.10.2022.
//

import Foundation
import Firebase

protocol CheckerServiceProtocol {
    func checkCredentials(login: String, pswd: String, completionGood: @escaping ()->Void,
                          completionBad: @escaping ()->Void)
    func signUp(login: String, pswd: String, completionGood: @escaping ()->Void,
                completionBad: @escaping ()->Void)
}


class CheckerService: CheckerServiceProtocol {

    func checkCredentials(login: String,
                          pswd: String,
                          completionGood: @escaping ()->Void,
                          completionBad: @escaping ()->Void) {


        FirebaseAuth.Auth.auth().signIn(withEmail: login, password: pswd)
        { result, error in
            guard error == nil else {
                completionBad()
                return
            }
            completionGood()
        }

    }


    func signUp(login: String,
                pswd: String,
                completionGood: @escaping ()->Void,
                completionBad: @escaping ()->Void) {
        FirebaseAuth.Auth.auth().createUser(withEmail: login, password: pswd)
        { result, error in
            guard error == nil else {
                completionBad()
                return
            }
            completionGood()
        }
    }
}

