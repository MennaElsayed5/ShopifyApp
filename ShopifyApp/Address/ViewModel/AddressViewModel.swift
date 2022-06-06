//
//  AddressViewModel.swift
//  ShopifyApp
//
//  Created by Peter Samir on 04/06/2022.
//

import Foundation
import RxSwift

protocol AddressViewModelProtocol{
    
    var networkObservable:Observable<Bool> { get set }
    var addressObservable:Observable<[Address]> { get set }
//    var addressSubject:PublishSubject<[Address]>{ get set }
    func getAddressesForCurrentUser(id:String)
    func checkConnection()
}

class AddressViewModel:AddressViewModelProtocol{
    
    var networkObservable: Observable<Bool>
    var networkSubject = PublishSubject<Bool>()
    var addressObservable: Observable<[Address]>
    private var addressSubject: PublishSubject<[Address]> = PublishSubject<[Address]>()
    var network:NetworkServiceProtocol
    
    init(network:NetworkServiceProtocol) {
        self.network = network
        addressObservable = addressSubject.asObserver()
        networkObservable = networkSubject.asObserver()
    }
    
    func getAddressesForCurrentUser(id:String) {
        network.getCustomerAddresses(id:id) { [weak self] response in
            switch response{
            case .success(let response):
                guard let res = response.addresses
                else {return}
                self?.addressSubject.asObserver().onNext(res)
                
            case .failure(let error):
                self?.addressSubject.asObserver().onError(error)
            }
        }
    }

    func postNewAddress(id:String, customerAddress:Address) {
//        network.postAddress(id: id) { response in
//            switch response {
//            case .success(let customerAddress):
//                    print("succeded")
//            case .failure(let error):
//                print("\(error.localizedDescription)")
//            }
//        }
    }
    
    
    func checkConnection() {
        HandelConnection.handelConnection.checkNetworkConnection { [weak self] isconn in
            if isconn{
                self?.networkSubject.asObserver().onNext(true)
            }else{
                self?.networkSubject.asObserver().onNext(false)
            }
        }
    }
}
