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
    var orderCount: Int = 0
}

struct Product {
    let name: String
    let price: Float
    let occupations: [String]
    let seller: String = "Satıcı"
    let usersRating: Int = 5
    let comments: [String] = ["İlk kullanıcı yorumu", "İkinci kullanıcı yorumu", "Üçüncü kullanıcı yorumu"]
}

class Cart {
    private let promotionDiscount: Float = 5
    static var shared = Cart()
    
    private(set) var products: [Product] = []
    
    var thereIsPromotion: Bool = false
    
    var totalPrice: Float {
        var sum: Float = 0
        for product in products {
            sum += product.price
        }
        if thereIsPromotion {
            sum -= promotionDiscount
        }
        return sum
    }
    
    func add(_ product: Product) {
        Self.shared.products.append(product)
    }
    
    func remove(_ product: Product) {
        
        for (n, e) in Cart.shared.products.enumerated() {
            if e.name == product.name {
                Cart.shared.products.remove(at: n)
            }
        }
    }
    
    func empty() {
        products.removeAll()
    }
}

enum PaymentMethod: CaseIterable {
    case sirinCilegi, cilekesKart
}


let products: [Product] = [
    Product(name: "Gözlük", price: 100.25, occupations: ["Gözlüklü Şirin"]),
    Product(name: "Topuklu Ayakkabı", price: 75.00, occupations: ["Şirine"]),
    Product(name: "Emzik", price: 5.75, occupations: ["Şirine"]),
    Product(name: "Beyaz Başlık", price: 25.25, occupations: ["Şirine", "Gözlüklü Şirin"]),
    Product(name: "Kırmızı Başlık", price: 30.00, occupations: ["Şirin Baba"]),
    Product(name: "Beyaz Eşofman", price: 60.50, occupations: ["Şirine", "Gözlüklü Şirin"]),
    Product(name: "Kırmızı Eşofman", price: 70.20, occupations: ["Şirin Baba"]),
    Product(name: "El Aynası", price: 12.45, occupations: ["Şirine"])
]

enum Occupation: Int {
    case sirinBaba = 0, sirine, gozluklu
}

var user = Smurf(name: "Emiralp", gender: "Erkek", age: "32", occupation: "Kodçu")

func registrationPage() {

    
    print("Şirinlesene'ye hoş geldiniz. Lütfen öncelikle kayıt olun.")

    print("İsminiz:")
    let name = readLine()!

    print("Cinsiyetiniz:")
    let gender  = readLine()!

    print("Yaşınız:")
    let age = readLine()!

    print("Mesleğiniz:\nLütfen aşağıdakilerden seçiniz:")
    print("Şirin Baba(0), Şirine(1), Gözlüklü Şirin(2) ?")

    var usersOccupation: Occupation = .gozluklu
    var isSelectionDone = false
    let range = 0...2
    
    while isSelectionDone == false {
        if let occupationNo = Int(readLine()!) {
            if range.contains(occupationNo) {
                usersOccupation = Occupation(rawValue: occupationNo) ?? .gozluklu
                isSelectionDone = true
            } else {
                print("Yanlış giriş yaptınız. Lütfen tekrar deneyin.")
                print("Şirin Baba(0), Şirine(1), Gözlüklü Şirin(2) ?")
            }
        }
        else {
            print("Yanlış giriş yaptınız. Lütfen tekrar deneyin.")
        }
    }
 
    var occupation: String = ""
    
    switch usersOccupation {
        
    case .sirinBaba:
        occupation = "Şirin Baba"
    case .sirine:
        occupation = "Şirine"
    case .gozluklu:
        occupation = "Gözlüklü Şirin"
    }


    user = Smurf(name: name, gender: gender, age: age, occupation: occupation)
    mainScreen()
}


func productDetails() {
    enum UserChoice: String, CaseIterable {
        case f, s, p
    }
    
    print("Hangi ürünle ilgili detay almak istersiniz?\n\n")
    
    for product in products {
        print("\(product.name)")
    }
    print()
    
    let usersProductName: String = readLine()!
    var usersProduct: Product = products[0]
    
    for product in products {
        if product.name == usersProductName {
            usersProduct = product
        }
    }
    
    print("Name: \(usersProduct.name)")
    print("Price: \(usersProduct.price)")
    print("Seller: \(usersProduct.seller)")
    print("Users' Rating: \(usersProduct.usersRating)")
    print("Bu ürünle ilgili kullanıcı yorumları:\n\n")
    
    for comment in usersProduct.comments {
        print("\(comment)\n\n")
    }
    
    var choice: UserChoice?
    
    while choice == nil {
        print("Ne yapmak istersiniz?\n")
        print("Favoriye ekle (f), Sepete ekle (s), Pazara dön (p)")
        let response = readLine()!
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
    case .f:
        user.favorites.append(usersProduct)
        print("Favorilere eklendi")
        mainScreen()
    case .s:
        Cart.shared.add(usersProduct)
        print("Sepete eklendi!")
        mainScreen()
    case .p:
        mainScreen()
    case .none:
        mainScreen()
    }
}

func cart() {
    enum UserChoice: String, CaseIterable {
        case ü, s, ö, p
    }
    
    print("Sepetinizdeki ürünler:\n")
    
    if Cart.shared.products.isEmpty {
        print("Sepetiniz boş.\n")
    } else {
        for product in Cart.shared.products {
            print("\(product.name)\n")
        }
    }
    
    print("Sepetinizin tutarı: \(Cart.shared.totalPrice)ŞÇ\n")
    
    var choice: UserChoice?
    
    while choice == nil {
        print("Ne yapmak istersiniz?\n")
        print("Ürün çıkar (ü), Sepeti boşalt (s), Ödemeye geç (ö), Pazara dön (p)")
        let response = readLine()!
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
        print("Hangi ürünü çıkarmak istersiniz? Lütfen adını girin.")
        let usersProductName: String = readLine()!
        var usersProduct: Product = products[0]
        
        for product in products {
            if product.name == usersProductName {
                usersProduct = product
            }
        }
        Cart.shared.remove(usersProduct)
        print("\(usersProduct.name) sepetinizden çıkarıldı.")
        cart()
    case .s:
        Cart.shared.empty()
        print("Sepetiniz boşaltıldı.")
        cart()
    case .ö:
        payment()
    case .p:
        mainScreen()
    case .none:
        mainScreen()
    }
}

func payment() {
    var paymentChoice: PaymentMethod = .sirinCilegi
    
    enum UserChoice: String, CaseIterable {
        case ö, p, d
    }
    
    
    print("Ödeme sayfasındasınız;\n\n")
    print("Toplam sepet tutarı: \(Cart.shared.totalPrice) ŞÇ")
    
    print("Ödeme seçenekleriniz;\n\n")
    
    for aCAse in PaymentMethod.allCases {
        switch aCAse {
        case .sirinCilegi:
            print("Şirin Çileği")
        case .cilekesKart:
            print("Çilekeş Kart")
        }
    }
    
    var choice: UserChoice?
    
    while choice == nil {
        print("Ne yapmak istersiniz?\n")
        print("Ödeme yöntemi seç ve öde (ö), Promosyon kodu ekle (p), Pazara dön (d)")
        let response = readLine()!
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
    case .ö:
        print("Ödeme yöntemi tercihinizi giriniz:")
        let usersChoiceInput = readLine()!
        
        if usersChoiceInput == "Çilekeş Kart" {
            paymentChoice = .cilekesKart
        }
        
        switch paymentChoice {
        case .sirinCilegi:
            print("Şirin Çileği ile kapıda ödeme yapılacak. Siparişiniz verildi. Toplam tutar: \(Cart.shared.totalPrice) ŞÇ")
            print("Teşekkürler!\n\n")
        case .cilekesKart:
            print("Siparişiniz verildi. \(Cart.shared.totalPrice) değerindeki tutar Çilekeş Kart'ınzdan çekildi.")
            print("Teşekkürler!\n\n")
        }
        Cart.shared.empty()
        Cart.shared.thereIsPromotion = false
        user.orderCount += 1
        mainScreen()
        
        
    case .p:
        let oldSum: Float = Cart.shared.totalPrice
        Cart.shared.thereIsPromotion = true
        print("Promosyon kodunuz eklenmiştir!")
        print("Eski tutar: \(oldSum)")
        print("Yeni tutar: \(Cart.shared.totalPrice)")
        payment()
    case .d:
        mainScreen()
    case .none:
        mainScreen()
    }
}

func profile() {
    print("Merhaba \(user.name)!\n\n")
    
    if user.favorites.isEmpty {
        print("Hiçbir favori ürünün bulunmamaktadır.")
    } else {
        print("Favori ürünlerin:")
        for product in user.favorites {
            print("\(product.name)")
        }
    }
        
    print("\nTeslimatta \(user.orderCount) adet siparişin bulunuyor.")
    
    print("Ana menüye dönmek için enter'a basınız.")
    let _ = readLine()!
    mainScreen()
}

func mainScreen() {
    enum UserChoice: String, CaseIterable {
        case ü, s, p, ç
    }

    print("\nÜrünlerimiz:\n")
    for product in products {
        if product.occupations.contains(user.occupation) {
            print(product.name)

        }
    }

    var choice: UserChoice?
    
    while choice == nil {
        print("Ne yapmak istersiniz?\n")
        print("Ürün detayları (ü), Sepetim (s), Profilim (p), Çıkış (ç)")
        let response = readLine()!
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

registrationPage()

