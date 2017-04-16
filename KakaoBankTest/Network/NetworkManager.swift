//
//  NetworkManager.swift
//  KakaoBankTest
//
//  Created by KyungJun Jeong on 2017. 4. 14..
//  Copyright © 2017년 KyungJun Jeong. All rights reserved.
//
struct RESPONSE_SUSCCESS {
    var resultArray:NSMutableArray?
    var detailModel:RankDetailDataModel?
}

struct RESPONSE_FAIL {
    var code:String?
    var message:String?
}

import UIKit
import Alamofire

class NetworkManager: NSObject {
    var currentRequest:Alamofire.Request?
    
    func requestCancel() {
        currentRequest?.cancel()
    }
    
    // List 조회
    func reqTopfreeapplications(resSuccess:@escaping (RESPONSE_SUSCCESS?) -> Void, resFail:@escaping (RESPONSE_FAIL?) -> Void) {
        currentRequest = Alamofire.request("https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json").responseJSON { (response) in
            
                        print(response.request as Any)  // original URL request
                        print(response.response as Any) // HTTP URL response
                        //            print(response.data)     // server data
                        print(response.result)   // result of response serialization
            
            guard response.response?.statusCode == 200 else {
                
                var res = RESPONSE_FAIL()
                res.code = "\(String(describing: response.response?.statusCode))"
                res.message = "network fail"
                
                return resFail(res)
                
            }
            
            if let jsonData:NSDictionary = response.result.value as? NSDictionary {
//                print(jsonData)
                
                var res = RESPONSE_SUSCCESS()
                res.resultArray = JsonParser().rankListParser(jsonDic: jsonData)
                
                return resSuccess(res)
                
            }
            else {
                                
                var res = RESPONSE_FAIL()
                res.code = "Unknoun Error"
                res.message = nil
                
                resFail(res)
            }
        }
    }
    
    // List 조회
    func reqLookUp(itemId:String, resSuccess:@escaping (RESPONSE_SUSCCESS?) -> Void, resFail:@escaping (RESPONSE_FAIL?) -> Void) {
        currentRequest = Alamofire.request("https://itunes.apple.com/lookup?id=\(itemId)&country=kr").responseJSON { (response) in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            //            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            guard response.response?.statusCode == 200 else {
                
                var res = RESPONSE_FAIL()
                res.code = "\(String(describing: response.response?.statusCode))"
                res.message = "network fail"
                
                return resFail(res)
                
            }
            
            if let jsonData:NSDictionary = response.result.value as? NSDictionary {
                //                print(jsonData)
                
                var res = RESPONSE_SUSCCESS()
                res.detailModel = JsonParser().rankDetailParser(jsonDic: jsonData)
                
                return resSuccess(res)
                
            }
            else {
                
                var res = RESPONSE_FAIL()
                res.code = "Unknoun Error"
                res.message = nil
                
                resFail(res)
            }
        }
    }
}
