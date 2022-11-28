//
//  NetworkError.swift
//  Navigation
//
//  Created by Alex M on 02.10.2022.
//

import Foundation

enum NetworkError: Error {
    case `default`
    case serverError
    case parseError(reason: String)
    case unknownError
}

