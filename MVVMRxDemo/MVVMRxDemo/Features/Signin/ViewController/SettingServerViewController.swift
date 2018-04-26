//
//  SettingServerViewController.swift
//  RemoteConference
//
//  Created by Master on 2018/4/26.
//  Copyright © 2018年 科大国创软件股份有限公司. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SettingServerViewController: BaseViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var serverIPOutlet: UITextField!
    @IBOutlet weak var serverPortOutlet: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func prepareView() {
        container.layer.masksToBounds = true
        container.layer.cornerRadius = 10
        
        cancelButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.87), for: .normal)
        cancelButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6), for: .highlighted)
        cancelButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3), for: .disabled)
        
        let norBgImage = UIImage(color: #colorLiteral(red: 0.09411764706, green: 0.5411764706, blue: 0.5098039216, alpha: 1))
        let higBgImage = UIImage(color: #colorLiteral(red: 0.09411764706, green: 0.5411764706, blue: 0.5098039216, alpha: 0.2))
        let disBgImage = UIImage(color: #colorLiteral(red: 0.09411764706, green: 0.5411764706, blue: 0.5098039216, alpha: 0.1))
        confirmButton.setBackgroundImage(norBgImage, for: .normal)
        confirmButton.setBackgroundImage(higBgImage, for: .highlighted)
        confirmButton.setBackgroundImage(disBgImage, for: .disabled)
        confirmButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        confirmButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6), for: .highlighted)
        confirmButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3), for: .disabled)
    }
    
    override func prepareViewModel() {
        cancelButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: bag)
    }

}
