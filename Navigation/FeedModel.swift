

import Foundation


final class FeedModel {

    private let secretWord = "qweasd"

    func check (word: String) -> Bool {
        word == self.secretWord ? true : false
    }

}
