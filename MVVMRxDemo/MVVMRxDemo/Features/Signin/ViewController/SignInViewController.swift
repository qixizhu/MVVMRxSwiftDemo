//
//  SignInViewController.swift
//  MVVMRxDemo
//
//  Created by Master on 2018/4/20.
//  Copyright © 2018年 七夕猪. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa
import SVProgressHUD

class SignInViewController: BaseViewController {
    
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var autoOutlet: UIButton!
    @IBOutlet weak var settingOutlet: UIButton!
    @IBOutlet weak var signInOutlet: UIButton!
    
    /// 用与监控 密码输入键盘 的 Return 按钮点击事件
    fileprivate let goReturnKeyTapSubject = PublishSubject<Void>()

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
        // 1.初始化 ViewModel
        let viewModel = SignInViewModel(
            input: (
                username: usernameOutlet.rx.text.orEmpty.asDriver(),
                password: passwordOutlet.rx.text.orEmpty.asDriver(),
                loginTaps: signInOutlet.rx.tap.asObservable(),
                goReturnKyeTaps: goReturnKeyTapSubject
            )
        )
        
        viewModel.signinEnabled.drive(signInOutlet.rx.isEnabled).disposed(by: bag)
        viewModel.signingIn.map { !$0 }.bind(to: autoOutlet.rx.isEnabled).disposed(by: bag)
        viewModel.signingIn.map { !$0 }.bind(to: settingOutlet.rx.isEnabled).disposed(by: bag)
        viewModel.signingIn.map { !$0 }.bind(to: usernameOutlet.rx.isEnabled).disposed(by: bag)
        viewModel.signingIn.map { !$0 }.bind(to: passwordOutlet.rx.isEnabled).disposed(by: bag)
        
        viewModel.signingIn
            .subscribe(onNext: {
                // TODO: - Show progress
                if $0 {
                    log.debug("progress start")
                    SVProgressHUD.showActivityIndicator()
                }
            })
            .disposed(by: bag)
        
        viewModel.signedIn
            .hideKeyboard()
            .subscribe(onNext: { (result) in
                // TODO: - show success message
                switch result {
                case .value(let object):
                    log.debug(object.code)
                    log.debug("success")
                    SVProgressHUD.showSuccess(with: "登录成功")
                case .error(let error):
                    log.error(error.localizedDescription)
                    log.debug("failura")
                    SVProgressHUD.showError(with: error.localizedDescription)
                }
            })
            .disposed(by: bag)
        
        viewModel.isAutoSignin
            .subscribe(onNext: { [weak self] (isAuto) in
                if isAuto {
                    self?.autoOutlet.setImage(#imageLiteral(resourceName: "selected_signin"), for: .normal)
                } else {
                    self?.autoOutlet.setImage(#imageLiteral(resourceName: "unselect_signin"), for: .normal)
                }
            }).disposed(by: bag)
        
        /// 自动登录按钮点击事件
        autoOutlet.rx.tap
            .subscribe(onNext: { [weak self] in
                if UserDefaultsHelper.shared.isAutoLogin {
                    UserDefaultsHelper.shared.isAutoLogin = false
                    UserDefaultsHelper.shared.loginName = nil
                    UserDefaultsHelper.shared.password = nil
                    viewModel.isAutoSignin.accept(false)
                } else {
                    UserDefaultsHelper.shared.isAutoLogin = true
                    UserDefaultsHelper.shared.loginName = self?.usernameOutlet.text
                    UserDefaultsHelper.shared.password = self?.passwordOutlet.text
                    viewModel.isAutoSignin.accept(true)
                }
            }).disposed(by: bag)
        
        /// 设置按钮点击事件
        settingOutlet.rx.tap
            .subscribe(onNext: { _ in
                let vc = SettingServerViewController()
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: true, completion: nil)
            }).disposed(by: bag)
        
        // 点击视图其它区域隐藏键盘
        let tapBackground = UITapGestureRecognizer()
        tapBackground.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: bag)
        view.addGestureRecognizer(tapBackground)
    }

}

// MARK: - Text field delegate
extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameOutlet {
            /// 由于 RxCocoa 的原因(目前还不知道什么原因)，必须在主线程中调用
            /// 才能起作用
            DispatchQueue.main.async {
                self.passwordOutlet.becomeFirstResponder()
            }
        } else {
            goReturnKeyTapSubject.onNext(())
        }
        
        return true
    }
}
