//
//  main_2.swift
//  week1_work1
//
//  Created by Emiralp Duman on 23.09.2022.
//

import Foundation

struct Smurf {
    let name: String
    let gender: String
    let age: String
    let occupation: String
    var favorites: [Product] = []
    var cart: [Product] = []
    
}

struct Product {
    let name: String
    let price: Float
    let seller: String = "Satıcı"
    let usersRating: Int = 5
    let comments: [String] = ["İlk kullanıcı yorumu", "İkinci kullanıcı yorumu", "Üçüncü kullanıcı yorumu"]
}

class Cart {
    var products: [Product] = []
    
    var totalPrice: Float {
        var sum: Float = 0
        for product in products {
            sum += product.price
        }
        return sum
    }
}
