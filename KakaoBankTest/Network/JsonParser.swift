//
//  JsonParser.swift
//  KakaoBankTest
//
//  Created by KyungJun Jeong on 2017. 4. 14..
//  Copyright © 2017년 KyungJun Jeong. All rights reserved.
//

import UIKit

class JsonParser: NSObject {
    func rankListParser(jsonDic:NSDictionary) -> NSMutableArray {
        let resultArray = NSMutableArray()
        
        let feed = jsonDic.object(forKey: "feed") as! NSDictionary
        
        guard let entry = feed.object(forKey: "entry") as? NSArray  else {
            return resultArray
           
        }
        
        for entryData in entry {
            let dataDic = entryData as! NSDictionary
            let listModel = RankListDataModel()
            
            let id = dataDic.object(forKey: "id") as! NSDictionary
            let attributes = id.object(forKey: "attributes") as! NSDictionary
            listModel.itemId = attributes.object(forKey: "im:id") as? String
            
            let imImage = dataDic.object(forKey: "im:image") as! NSArray
            let imageItem = imImage[2] as! NSDictionary
            listModel.image = imageItem.object(forKey: "label") as? String
            
            let imName = dataDic.object(forKey: "im:name") as! NSDictionary
            listModel.title = imName.object(forKey: "label") as? String

            resultArray.add(listModel)
        }

        
        return resultArray
    }
    
    func rankDetailParser(jsonDic:NSDictionary) -> RankDetailDataModel {
        let rankDetailModel = RankDetailDataModel()
        
        print("jsonDic : \(jsonDic)")
        
        let results = jsonDic.object(forKey: "results") as! NSArray
        let detailDic = results[0] as! NSDictionary
        
        rankDetailModel.image = detailDic.object(forKey: "artworkUrl512") as? String
        rankDetailModel.title = detailDic.object(forKey: "trackName") as? String
        rankDetailModel.rating = (detailDic.object(forKey: "averageUserRating") as! NSNumber?)?.stringValue
        rankDetailModel.screenShots = detailDic.object(forKey: "screenshotUrls") as? NSArray
        rankDetailModel.appInfo = detailDic.object(forKey: "description") as? String
//        
//        let feed = jsonDic.object(forKey: "feed") as! NSDictionary
//        
//        guard let entry = feed.object(forKey: "entry") as? NSArray  else {
//            return resultArray
//            
//        }
//        
//        print("entry : \(entry)")
//        
//        for entryData in entry {
//            let dataDic = entryData as! NSDictionary
//            let listModel = RankListDataModel()
//            
//            let id = dataDic.object(forKey: "id") as! NSDictionary
//            let attributes = id.object(forKey: "attributes") as! NSDictionary
//            listModel.itemId = attributes.object(forKey: "im:id") as? String
//            
//            let imImage = dataDic.object(forKey: "im:image") as! NSArray
//            let imageItem = imImage[2] as! NSDictionary
//            listModel.image = imageItem.object(forKey: "label") as? String
//            
//            let imName = dataDic.object(forKey: "im:name") as! NSDictionary
//            listModel.title = imName.object(forKey: "label") as? String
//            
//            resultArray.add(listModel)
//        }
//        
//        print("resultArray : \(resultArray)")
        
        
        return rankDetailModel
    }

}


