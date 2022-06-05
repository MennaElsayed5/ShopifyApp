//
//  LoginViewController.swift
//  ShopifyApp
//
//  Created by Radwa on 24/05/2022.
//

import UIKit
import TextFieldEffects
import NVActivityIndicatorView
class LoginViewController: UIViewController {

    @IBOutlet weak var emailLabel: MadokaTextField!
    @IBOutlet weak var passwordLabel: MadokaTextField!
    var viewModel: LoginViewModelType!
    let indicator = NVActivityIndicatorView(frame: .zero, type: .ballRotateChase, color: .label, padding: 0)
    var email, password: String!
    override func viewDidLoad() {
        super.viewDidLoad()
            self.viewModel = LoginViewModel()
            self.bindToViewModel()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func bindToViewModel(){
        viewModel.bindNavigate = { [weak self] in
            self?.showActivityIndicator(indicator: self?.indicator, startIndicator: false)
            self?.navigate()
        }
        viewModel.bindDontNavigate = { [weak self] in
            let message = self?.viewModel.alertMessage ?? "Can't login, please check your information"
            self?.showAlret(message: message)
        }
    }
   
    func navigate(){
        DispatchQueue.main.async {
            self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
//         let a = HomeViewController(nibName:"HomeViewController", bundle: nil)
//         self.navigationController?.pushViewController(a, animated: true)
            self.navigationController?.popViewController(animated: true)
        }
    }
    func showAlret(message:String){
        DispatchQueue.main.async {
            self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
            let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
       
    }

    @IBAction func loginBtn(_ sender: Any) {
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        email = emailLabel.text ?? ""
        password = passwordLabel.text ?? ""
        viewModel.loginCustomer(email: email, password: password)
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        DispatchQueue.main.async {
         let a = RegisterViewController(nibName:"RegisterViewController", bundle: nil)
         self.navigationController?.pushViewController(a, animated: true)
       
        }
    }


}
