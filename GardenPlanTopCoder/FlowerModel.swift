//
//  FlowerModel.swift
//  GardenPlanTopCoder
//
//  Created by 藤井陽介 on 2016/04/09.
//  Copyright © 2016年 touyou. All rights reserved.
//

import Foundation
import UIKit

class Flower: NSObject, NSCoding {
    var name: String!
    var color: UIColor!
    init (name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
    
    init (dict: Dictionary<String, AnyObject>) {
        for (key, value) in dict {
            switch key {
            case "name":
                name = value as! String
            case "color":
                color = value as! UIColor
            default:
                break
            }
        }
    }
    
    func toDict() -> Dictionary<String, AnyObject> {
        var dict = Dictionary<String, AnyObject>()
        dict["name"] = name
        dict["color"] = color
        return dict
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(color, forKey: "color")
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as? String
        color = aDecoder.decodeObjectForKey("picture") as? UIColor
        super.init()
    }
}

class Bed: NSObject, NSCoding {
    let MAX_NUM: Int = 5
    var flowers: [Flower]!
    var name: String!
    
    override init() {
        flowers = [Flower]()
        name = ""
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        for (key, value) in dict {
            switch key {
            case "name":
                name = value as! String
            case "flowers":
                flowers = (value as! [Dictionary<String, AnyObject>]).map { Flower(dict: $0) }
            default:
                break
            }
        }
    }
    
    func setFlower(flower: Flower) -> Int {
        if self.flowers.count >= self.MAX_NUM {
            return -1
        }
        flowers.append(flower)
        return 0
    }
    
    func getSize() -> Int {
        return self.flowers.count
    }
    
    func getFlowers() -> [Flower] {
        return self.flowers
    }
    
    func toDict() -> Dictionary<String, AnyObject> {
        var dict = Dictionary<String, AnyObject>()
        dict["name"] = name
        dict["flowers"] = flowers.map { $0.toDict() } as AnyObject
        return dict
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(flowers.map { $0.toDict() }, forKey: "flowers")
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as? String
        let fls = aDecoder.decodeObjectForKey("flowers") as? [Dictionary<String, AnyObject>]
        if let temp = fls?.map({ Flower(dict: $0) }) {
            flowers = temp
        } else {
            flowers = [Flower]()
        }
        super.init()
    }
}