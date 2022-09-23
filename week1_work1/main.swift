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

let products: [Product] = [
    Product(name: "Gözlük", price: 100.25),
    Product(name: "Çekiç", price: 50.50),
    Product(name: "Topuklu Ayakkabı", price: 75.00),
    Product(name: "Emzik", price: 5.75),
    Product(name: "Beyaz Başlık", price: 25.25),
    Product(name: "Kırmızı Başlık", price: 30.00),
    Product(name: "Kalem", price: 4.00),
    Product(name: "Beyaz Eşofman", price: 60.50),
    Product(name: "Kırmızı Eşofman", price: 70.20),
    Product(name: "El Aynası", price: 12.45)
]

let occupations: [String] = ["Şirin Baba", "Şirine", "Güçlü", "Gözlüklü", "Şakacı", "Somurtkan", "Hayalci", "Sakar", "Obur", "Aşçı", "Süslü"]

enum PaymentMethod {
    case sirinCilegi, cilekesKart
}

func productDetails() {
    
}

func cart() {
    
}

func profile() {
    
}

func mainScreen() {
    
    enum UserChoice: String, CaseIterable {
        case ü, s, p, ç
    }
    print("\nÜrünlerimiz:\n")
    
    for product in products {
        print(product.name)
    }

    var choice: UserChoice?
    
    while choice == nil {
        print("Ne yapmak istersiniz?\n")
        print("Ürün detayları (ü), Sepet (s), Profilim (p), Çıkış (ç)")
        var response = readLine()!
        for aCase in UserChoice.allCases {
            if response == aCase.rawValue {
                choice = aCase
            }
        }
        if choice == nil {
            print("Geçerli bir giriş yapmadınız. Lütfen tekrar giriş yapın")            
        }
    }
    
    switch choice {
    case .ü:
        productDetails()
    case .s:
        cart()
    case .p:
        profile()
    case .ç:
        exit(0)
    case .none:
        mainScreen()
    }
}


