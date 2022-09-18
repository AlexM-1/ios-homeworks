
import Foundation
import UIKit


class BruteForce {

    private var passwordToUnlock: String = ""
    private let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }

    func bruteForce() -> String {

        var password: String = ""
        let startTimeChrome = CACurrentMediaTime()
        while password != self.passwordToUnlock {
            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
        }

        let endTime = CACurrentMediaTime()
        print("Total time bruteForce: \(endTime - startTimeChrome) s")
        print("you password is", password)
        return password
    }

    func generatePassword(digits: Int) {

        var password = ""

        for _ in 1...digits {
            password += ALLOWED_CHARACTERS.randomElement()!

        }

        self.passwordToUnlock = password
        print("generated password is \(self.passwordToUnlock)")

    }



    private func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }

    private func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index])
        : Character("")
    }

    private func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string

        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        }
        else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }

        return str
    }

}


extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }



    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}
