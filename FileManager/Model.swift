//
//  Model.swift
//  FileManager
//
//  Created by Alex M on 14.10.2022.
//

import Foundation

class Model {

    enum State {
        case passwordNotCreated
        case passwordIsSaved
        case changePassword
    }

    var state: State = .passwordNotCreated

    var userName = "Alex"
    var keyChain = KeyChain()

}
