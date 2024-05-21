//
//  Database.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 17/05/24.
//

import RealmSwift

class Database {
    static let shared : Database = Database()
    var notificationToken: NotificationToken?
    private init() { }
    
    deinit {
        notificationToken?.invalidate()
    }
}

extension Database: CartDB {
   
    func getCartItem(usingSkuId skuId: String) -> CartItem {
        
        let realm = try! Realm()
        guard let realmObject = realm.objects(RealmCartItem.self).first(where: { $0.skuId == skuId }) else {
            return CartItem(skuId: skuId, value: 0)
        }
        return CartItem(realmCartItem: realmObject)
    }
  
    
    func updateCart(using cartItem: CartItem) -> (Bool) {
        let realm = try! Realm()
        
        do {
            try realm.write {
                realm.add(RealmCartItem(cartItem: cartItem), update: .all)
            }
        } catch {
            print("Something went wrong with error: \(error)")
            return false
        }
        return true
    }
    
    
    func getCount(closure: @escaping CartCountClosure) {
        
        let realm = try! Realm()
        let results = realm.objects(RealmCartItem.self)
        
        notificationToken = results.observe({ _ in
            closure(results.count)
        })
    }
    
    func delete(usingSkuId skuId: String) -> (Bool) {
        let realm = try! Realm()
        
        do {
            try realm.write {
                if let realmObject = realm.objects(RealmCartItem.self).first(where: { $0.skuId == skuId }) {
                    realm.delete(realmObject)
                }
            }
        } catch {
            print("Something went wrong with error: \(error)")
            return false
        }
        return true
    }
    
}
