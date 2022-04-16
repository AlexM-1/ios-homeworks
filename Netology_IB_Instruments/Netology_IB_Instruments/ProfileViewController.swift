//
//  ProfileViewController.swift
//  Netology_IB_Instruments
//
//  Created by Alex M on 11.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let screenWidth = UIScreen.main.bounds.width

        let view = UINib(nibName: "ProfileView", bundle: .main).instantiate(withOwner: nil, options: nil).first as! UIView
        view.frame = CGRect(x: 16, y: 50, width: screenWidth-32, height: 350)
        self.view.addSubview(view)

    }

}
