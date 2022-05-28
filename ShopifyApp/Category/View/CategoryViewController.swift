//
//  CategoryViewController.swift
//  ShopifyApp
//
//  Created by Peter Samir on 20/05/2022.
//

import UIKit
import Floaty
import RxSwift
class CategoryViewController: UIViewController {

    let disposeBag = DisposeBag()
    var showList:[ProductElement]?
    let refreshController = UIRefreshControl()
    var viewModel:CategoryViewModelProtocol!
    

    @IBOutlet weak var noDataImg: UIImageView!
    @IBOutlet weak var labelNoData: UILabel!
    @IBOutlet weak var sale: UIBarButtonItem!
    @IBOutlet weak var kids: UIBarButtonItem!
    @IBOutlet weak var men: UIBarButtonItem!
    @IBOutlet weak var women: UIBarButtonItem!
    @IBOutlet private weak var fabBtn: Floaty!
    @IBOutlet  weak var categoryCollection: UICollectionView!
    var collectionFlowLayout:UICollectionViewFlowLayout!
    
    override func viewWillAppear(_ animated: Bool) {
        if let showList = showList {
            if !showList.isEmpty{
                labelNoData.isHidden = true
                noDataImg.isHidden = true
            }
        }
        
    }
    
    override func viewWillLayoutSubviews() {
            addNavController()
    }
    
    func addNavController() {
        let width = self.view.frame.width
        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 35, width: width, height: 10));       self.view.addSubview(navigationBar)
        let searchBtn = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(self.cartBtn))
        navigationItem.title = "Category"
        let favoriteBtn = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(selectorX))
        let cartBtn = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .done, target: self, action: #selector(cartBtn))
        navigationItem.leftBarButtonItem = searchBtn
        navigationItem.rightBarButtonItems = [favoriteBtn, cartBtn]
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    @objc func cartBtn(){
        print("cart pressed")
    }
    
    @objc func selectorX() {print("cart pressed") }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        showList = []
        viewModel = CategoryViewModel(network: APIClient())
        setupCollectionView()
        fabBtn.addItem("Shoes", icon: UIImage(named: "heart")) { [weak self] _ in
            let index = self?.getSelectedIndexInToolBar(type: "SHOES")
            self?.getCategory(target: .ShoesType(id: index!.ID))
           self?.checkListSize(productName: "SHOES")
//            self?.categoryCollection.reloadData()
        }
        fabBtn.addItem("T_shirts", icon: UIImage(named: "star")) {[weak self] _ in
            let index = self?.getSelectedIndexInToolBar(type: "T-SHIRTS")
            self?.getCategory(target: .TshirtType(id: index!.ID))
           self?.checkListSize(productName: "T-SHIRTS")
//            self?.categoryCollection.reloadData()
        }
        fabBtn.addItem("Accecories", icon: UIImage(named: "heart")) {[weak self] _ in
            let index = self?.getSelectedIndexInToolBar(type: "ACCESSORIES")
            self?.getCategory(target: .AccecoriesType(id: index!.ID))
           self?.checkListSize(productName: "ACCESSORIES")
//            self?.categoryCollection.reloadData()
        }
        fabBtn.buttonColor = UIColor.black
        fabBtn.plusColor = UIColor.white
        refreshController.tintColor = UIColor.blue
        refreshController.addTarget(self, action: #selector(getData), for: .valueChanged)
        categoryCollection.addSubview(refreshController)
        getCategory(target: .HomeCategoryProducts)
        womenBtnAction()
        menBtnAction()
        kidsBtnAction()
        saleBtnAction()
    }
    
    @objc func getData(){
        //MARK: will check network and reload data from api
        refreshController.endRefreshing()
        categoryCollection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupCollectionItemSize()
    }
    
    func setupCollectionView(){
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        categoryCollection.register(nib, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    }
    
    func menBtnAction() {
        men.rx.tap.throttle(RxTimeInterval.seconds(2), latest: false, scheduler: MainScheduler.instance).subscribe {[weak self] _ in
            self?.getCategory(target: .MenCategoryProduct)
            self?.checkHilightedBtnInToolbar(index: 2)
            self?.categoryCollection.reloadData()
        }.disposed(by: disposeBag)
    }
    
    func womenBtnAction(){
        women.rx.tap.throttle(RxTimeInterval.seconds(2), latest: false, scheduler: MainScheduler.instance).subscribe {[weak self] _ in
            self?.getCategory(target: .WomenCategoryProduct)
            self?.checkHilightedBtnInToolbar(index: 1)
            self?.categoryCollection.reloadData()
        }.disposed(by: disposeBag)
    }
    
    func saleBtnAction() {
        sale.rx.tap.throttle(RxTimeInterval.seconds(2), latest: false, scheduler: MainScheduler.instance).subscribe {[weak self] _ in
            self?.getCategory(target: .SaleCategoryProduct)
            self?.checkHilightedBtnInToolbar(index: 4)
            self?.categoryCollection.reloadData()
        }.disposed(by: disposeBag)
    }
    
    func kidsBtnAction() {
        kids.rx.tap.throttle(RxTimeInterval.seconds(2), latest: false, scheduler: MainScheduler.instance).subscribe {[weak self] _ in
            self?.getCategory(target: .KidsCategoryProduct)
            self?.checkHilightedBtnInToolbar(index: 3)
            self?.categoryCollection.reloadData()
        }.disposed(by: disposeBag)
    }
    
    func checkHilightedBtnInToolbar(index:Int) {
        switch index{
        case 1:
            women.isSelected = true
            men.isSelected = false
            kids.isSelected = false
            sale.isSelected = false
        case 2:
            women.isSelected = false
            men.isSelected = true
            kids.isSelected = false
            sale.isSelected = false
        case 3:
            women.isSelected = false
            men.isSelected = false
            kids.isSelected = true
            sale.isSelected = false
        case 4:
            women.isSelected = false
            men.isSelected = false
            kids.isSelected = false
            sale.isSelected = true
        default:
            women.isSelected = false
            men.isSelected = false
            kids.isSelected = false
            sale.isSelected = false
        }
    }
    
    func getSelectedIndexInToolBar(type:String)-> categoryID {
        if women.isSelected {
            return .WOMEN
        }else if men.isSelected{
            return .MEN
        }else if kids.isSelected{
            return .KIDS
        }else if sale.isSelected{
            return .SALE
        }
        return .Home(type: type)
    }
}

