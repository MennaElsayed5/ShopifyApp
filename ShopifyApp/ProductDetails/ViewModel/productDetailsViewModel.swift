//
//  productDetailsViewModel.swift
//  ShopifyApp
//
//  Created by Radwa on 25/05/2022.
//

import Foundation
import RxCocoa
import RxSwift

protocol ProductDetailsViewModelType{
    func  getProduct(id:String)
    func  getAllProducts()
    var  favoriteProducts : [FavoriteProducts]? {get set}
    var  productObservable: Observable<Product>{get set}
    var allProductsObservable :Observable<[Product]>{get set}
    var favoriteProductObservable: Observable<[FavoriteProducts]>{get set}
    func addFavouriteProductToCoreData(product:Product , completion: @escaping (Bool)->Void) throws
    func getAllFavoriteProducts(completion: @escaping (Bool)->Void) throws
}

//https://c48655414af1ada2cd256a6b5ee391be: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@mobile-ismailia.myshopify.com/admin/api/2022-04/products/7782820085989.json

final class ProductDetailsViewModel: ProductDetailsViewModelType{
    var favoriteProducts: [FavoriteProducts]?
    
   
    
    private var listOfProduct : [Product] = []
    var network = APIClient()
    var localDataSource :LocalDataSource
   
    var productObservable: Observable<Product>
    var allProductsObservable :Observable<[Product]>
    var favoriteProductObservable: Observable<[FavoriteProducts]>
    private var productSubject: PublishSubject = PublishSubject<Product>()
    private var allProductsSubject : PublishSubject = PublishSubject<[Product]>()
    private var favoriteProductSubject : PublishSubject = PublishSubject<[FavoriteProducts]>()

    
   
    init(appDelegate :AppDelegate){
        localDataSource = LocalDataSource(appDelegate: appDelegate)
        productObservable = productSubject.asObserver()
        allProductsObservable = allProductsSubject.asObserver()
        favoriteProductObservable = favoriteProductSubject.asObserver()
    }
    
    

    func getProduct(id:String) {
        network.productDetailsProvider(id: id, completion: {[weak self] result in
            switch result {
            case .success(let response):
                guard let product = response.product else {return}
                self?.productSubject.asObserver().onNext(product)
                print(product.title)
            case .failure(let error):
                self?.productSubject.asObserver().onError(error)
                print(error.localizedDescription)
            }
        })
        

    }


    func getAllProducts() {
        network.getAllProduct { [weak self] result in
            switch result {
               
            case .success(let response):
                guard let allProducts = response.products else{return}
                self?.listOfProduct = allProducts
                self?.allProductsSubject.asObserver().onNext(allProducts)
            case .failure(let error):
                self?.allProductsSubject.asObserver().onError(error)
            }
        }
    }

    func getAllFavoriteProducts(completion: @escaping (Bool)->Void) throws{
        
        do{
            try favoriteProducts =   localDataSource.getProductFromCoreData()
           // self.favoriteProductSubject.asObserver().onNext(favoriteProducts)
            completion(true)
        }catch let error{
            completion(false)
            throw error
        }
    }
    
    func searchWithWord(word:String){
        if word.isEmpty{
            allProductsSubject.onNext(listOfProduct)
            return
        }
            let filterProducts = listOfProduct.filter { Product in
                return Product.title.lowercased().contains(word.lowercased())
        }
        allProductsSubject.onNext(filterProducts)

    }
    
    func addFavouriteProductToCoreData(product:Product , completion: @escaping (Bool)->Void) throws{
        
        do{
            try  localDataSource.saveProductToCoreData(newProduct: product)
            completion(true)
        }
        catch let error{
            completion(false)
            throw error
        }
    }
 

}
