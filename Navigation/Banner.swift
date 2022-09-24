
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
                    title: "Нравится наше приложение?",
                    message: "Найдите время оставить отзыв в App Store",
                    preferredStyle: .alert)

                let cancelAction = UIAlertAction(title: "Больше не напоминать", style: .default) { _ in

                    self.timer?.invalidate()
                    self.timer = nil
                }

                let laterAction = UIAlertAction(title: "Позже", style: .default) { _ in print("tapped Позже")
                    self.isShow = false
                }


                let OKAction = UIAlertAction(title: "Оценить", style: .default)
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
