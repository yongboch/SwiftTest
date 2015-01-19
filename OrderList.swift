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
    
    
    var newOrders = [Order]()
    var activeOrders = [Order]()
    var finishOrders = [Order]()
    
    ///orginal order list
    var jsonList = [String:Order]()
    
    ///load json and convert it to order list
    func loadJson(json: Array<AnyObject>){
        for item in json{
            var order = Order(json: item)
            var id = order.id
            jsonList[id] = order
        }
    }
    
    ///add new order to order list
    func addJson(json:AnyObject){
        var order = Order(json:json)
        var id = order.id
        jsonList[id] = order
    }
    
    ///update order 
    func updateOrder(order:Order){
        jsonList.updateValue(order, forKey: order.id)
    }
    
    ///return dictionary of orders with sections
    var orders:[String:AnyObject]{
        get {
            self.reOrderList()
            return ["New":newOrders, "Active":activeOrders, "Finish":finishOrders]
        }
    }
    
    /// sections
    var typeList:Array<String>{
        get {
            return ["New", "Active", "Finish"]
        }
    }
    
    /// after data changed, refresh and reorder order list
    func reOrderList(){
        newOrders.removeAll(keepCapacity: false)
        activeOrders.removeAll(keepCapacity: false)
        finishOrders.removeAll(keepCapacity: false)
        for (id, order) in jsonList {
            var status = order.status
            if status == 4 {
                newOrders.append(order)
            } else if status > 4 && status < 8 {
                activeOrders.append(order)
            } else {
                finishOrders.append(order)
            }
        }
    }
    
    
}
