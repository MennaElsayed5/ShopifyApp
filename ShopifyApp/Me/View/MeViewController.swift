//
//  MeViewController.swift
//  ShopifyApp
//
//  Created by AbdElrahman sayed on 20/05/2022.
//

import UIKit

class MeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func asd(_ sender: Any) {
//        let a = FavouriteViewController(nibName: "FavouriteViewController", bundle: nil)
//         self.navigationController?.pushViewController(a, animated: true)
    }
    
    @IBAction func navToPayment(_ sender: Any) {
        let payment = PaymentMethodViewController(nibName: "PaymentMethodViewController", bundle: nibBundle)
        self.navigationController?.pushViewController(payment, animated: true)
    }
}
