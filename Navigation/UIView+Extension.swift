

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
}



extension String {
    var localizable: String {
        NSLocalizedString(self, comment: "")
    }

}



