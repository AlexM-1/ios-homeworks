
import Foundation
import UIKit

class Banner {

    var vc: UIViewController?

    private var timer: Timer?

    private var isShow: Bool = false


    func show() {

        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 300.0, repeats: true) { timer in



                let alert = UIAlertController(
                    title: "Do you like our app?".localizable,
                    message: "Take the time to leave a review in the App Store".localizable,
                    preferredStyle: .alert)

                let cancelAction = UIAlertAction(title: "Don't remind me anymore".localizable, style: .default) { _ in

                    self.timer?.invalidate()
                    self.timer = nil
                }

                let laterAction = UIAlertAction(title: "Later".localizable, style: .default) { _ in print("tapped Later")
                    self.isShow = false
                }


                let OKAction = UIAlertAction(title: "Estimate".localizable, style: .default)
                { _ in print("tapped Оценить")
                    self.timer?.invalidate()
                    self.timer = nil
                }

                alert.addAction(cancelAction)
                alert.addAction(OKAction)
                alert.addAction(laterAction)
                alert.preferredAction = OKAction

                if !self.isShow {
                    self.vc?.present(alert, animated: true) {
                        self.isShow = true

                    }
                }

            }


        }

    }
}
