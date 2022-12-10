//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Alex M on 03.12.2022.
//

import LocalAuthentication

final class LocalAuthorizationService {


    enum BiometricType: String {
        case none   // The device does not support biometry
        case touch = "Touch ID"
        case face = "Face ID"
        case unknown
    }



    private let context = LAContext()
    private let policy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
    private var error: NSError?


    var biometricType: BiometricType {

        if #available(iOS 11, *) {
            let _ = context.canEvaluatePolicy(policy, error: nil)
            switch(context.biometryType) {
            case .none:
                return .none
            case .touchID:
                return .touch
            case .faceID:
                return .face
            @unknown default:
                return .unknown
            }
        } else {
            return context.canEvaluatePolicy(policy, error: nil) ? .touch : .none
        }
    }


    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool, String?) -> Void) {


        guard context.canEvaluatePolicy(policy, error: &error) else {
            if error?.code == -6 {
                authorizationFinished(false, "Функция \(biometricType.rawValue) отключена. Перейдите в Настройки, чтобы активировать.")
            } else {
                authorizationFinished(false, error?.localizedDescription)
            }
            return
        }

        if let error = error {
            authorizationFinished(false, error.localizedDescription)
            return
        }

        context.localizedFallbackTitle = ""

        context.evaluatePolicy(
            policy,
            localizedReason: "Авторизуйтесь для входа") { success, error in

                if let error = error {
                    print(error)
                    authorizationFinished(false, error.localizedDescription)
                    return
                }
                authorizationFinished(success, nil)
            }
    }

}

