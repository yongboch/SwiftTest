//
//  OrderList.swift
//  Test
//
//  Created by Yongbo on 1/15/15.
//  Copyright (c) 2015 Yongbo. All rights reserved.
//

import Foundation

class OrderList{
    struct Static {
        static let instance = OrderList()
    }
    class var sharedInstance:OrderList{
        return Static.instance
    }
    
    
    var newOrders = [String:AnyObject]()
    var activeOrders = [String:AnyObject]()
    var finishOrders = [String:AnyObject]()
    var jsonList = [String:AnyObject]()
    
    func loadJson(json: Array<AnyObject>){
        for item in json{
            var order = item as Dictionary<String, AnyObject>
            var id = order["id"] as String
            jsonList[id] = order
        }
    }
    var orderList:[String:AnyObject]{
        get {
            self.reOrderList()
            return ["New":newOrders, "Active":activeOrders, "Finish":finishOrders]
        }
    }
    
    var typeList:Array<String>{
        get {
            return Array(orderList.keys)
        }
    }
    
    func reOrderList(){
        for (key, value) in jsonList {
            var order = value as Dictionary<String, AnyObject>
            var status = order["status"] as Int
            //var orderno = order["orderno"] as String
            if status == 4 {
                newOrders[key] = order
            } else if status > 4 && status < 8 {
                activeOrders[key] = order
            } else {
                finishOrders[key] = order
            }
        }
    }
    
    
}
