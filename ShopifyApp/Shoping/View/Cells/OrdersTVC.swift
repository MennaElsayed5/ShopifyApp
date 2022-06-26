//
//  OrdersTVC.swift
//  Shopify
//
//  Created by Menn on 24/05/2022.
//

import UIKit
import Kingfisher

class OrdersTVC : UITableViewCell {
    var productVM : ProductDetailsViewModel?
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    
    @IBOutlet weak var trash_icon: UIButton!
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var productCount: UILabel!
    
    @IBOutlet weak var subBtn: UIButton!
    static let identifier = "ordersTVC"
    var item: LineItem?
    var itemsImages = ""
    var totalPrice=0.0

    static func nib() ->UINib{
        UINib(nibName: "OrdersTVC", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        productVM = ProductDetailsViewModel(appDelegate: (UIApplication.shared.delegate as? AppDelegate)!)

    }
    func updateUI(item: LineItem) {
        self.item = item
        productTitle.text = item.title
        productCount.text = String(describing: item.quantity)
        let id = String(describing: item.productID)
        productVM!.getProductImage(id: id)
        productVM!.bindImageURLToView = { self.onSuccessUpdateView() }
        productPrice.text = Shared.formatePrice(priceStr: String(item.price))
    }
    func onSuccessUpdateView() {
        itemsImages = productVM!.imageURL!
        DispatchQueue.main.async {
            let processor = DownsamplingImageProcessor(size: self.productImage.bounds.size)
            self.productImage.kf.indicatorType = .activity
            self.productImage.kf.setImage(
                with:URL(string: self.itemsImages),
                placeholder: UIImage(named: "placeholderImage"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .cacheOriginalImage
                ])

        }
    }
    var deleteFromBagProducts:()->() = {}
    var addCount:()->() = {}
    var subCount:()->() = {}
    @IBAction func deleteCart(_ sender: Any) {
        deleteFromBagProducts()
    }
    @IBAction func subCount(_ sender: Any) {
        
        subCount()
    }
    @IBAction func addCount(_ sender: Any) {
        addCount()

  }
}
