//
//  SignInViewController.swift
//  MVVMRxDemo
//
//  Created by Master on 2018/4/20.
//  Copyright © 2018年 七夕猪. All rights reserved.
//

import UIKit

class SignInViewController: BaseViewController {
    
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var autoOutlet: UIButton!
    @IBOutlet weak var settingOutlet: UIButton!
    @IBOutlet weak var signInOutlet: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepareView() {
        let bgImage = UIImage(color: #colorLiteral(red: 0.09411764706, green: 0.5294117647, blue: 0.4980392157, alpha: 1))
        signInOutlet.setBackgroundImage(bgImage, for: .normal)
        let disbgImage = UIImage(color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        signInOutlet.setBackgroundImage(disbgImage, for: .disabled)
        signInOutlet.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.53), for: .disabled)
    }
    
    override func prepareViewModel() {
        
    }

}
