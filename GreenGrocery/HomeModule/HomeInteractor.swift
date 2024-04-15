//
//  HomeInteractor.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 15/04/24.
//

import Foundation

protocol HomeUseCase {
    func getTitle() -> HomeModel
}

class HomeInteractor {
    
}

extension HomeInteractor: HomeUseCase {
    
    func getTitle() -> HomeModel {
        return HomeModel(title: "Home Viper")
    }
    
}
