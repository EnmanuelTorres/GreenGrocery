//
//  Database.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 17/05/24.
//

import RealmSwift


class Database {
    static let shared : Database = Database()
    private init() { }
}

extension Database: CartDB {
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
    
    
}
