//
//  Order.swift
//  Test
//
//  Created by Yongbo on 1/16/15.
//  Copyright (c) 2015 Yongbo. All rights reserved.
//

import Foundation

class Order{
    var orderno:String
    var id:String
    var status:Int
    
    var userInfo = [String:AnyObject]()
    var restaurant = [AnyObject]()
    var dishes = [Dish]()
    
    init(json:AnyObject){
        var order = json as Dictionary<String,AnyObject>
        self.id = json["id"] as String
        self.orderno = json["orderno"] as String
        self.status = json["status"] as Int
        initUserInfo(order["address"]!)
        initDishes(order["dish"]!)
        
    }
    
    func initUserInfo(a:AnyObject){
        var address = a as Dictionary<String, String>
        //var name:String =
        userInfo["Name"] = address["first_name"]! +  address["last_name"]!
        userInfo["Tel"] = address["phone"]!
        userInfo["Address"] = address["address"]! + address["room"]!
            + address["city"]! + address["state"]!
            + address["zip"]!
    }
    func initDishes(d:AnyObject){
        
    }
    
    var userInfoTitle:[String]{
        get{
            return ["Name", "Tel", "Address"]
        }
    }
    
    var restaurantTitle:[String] {
        get{
            return ["Name"]
        }
    }
    
    
    
    var detail:[String:AnyObject]{
        get{
            return ["User Info":userInfo, "Restaurant":"", "Dishes":""]
        }
    }
    
    
    
}

class Dish{
    var name:String
    var name_en:String
    var quantity:Int
    init(dish:[String:AnyObject]){
        self.name = dish["name"] as String
        self.name_en = dish["name_en"] as String
        self.quantity = dish["quantity"] as Int
    }
}
