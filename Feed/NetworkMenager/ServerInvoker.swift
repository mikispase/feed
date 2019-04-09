//
//  ServerInvoker.swift
//  test
//
//  Created by Dimitar Spasovski on 4/8/19.
//  Copyright © 2018 Dimitar Spasovski. All rights reserved.
//

import Foundation
import Alamofire

typealias CompletitionDictonary = (_ result: Dictionary<String,Any>) -> Void
typealias CompletitionArray = (_ result: Array<Any>) -> Void


func prettyPrint(with json: [String:Any]) -> String{
    let data = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
    return string! as String
}

func ServerInvoker_allFeeds(onComplete:@escaping CompletitionArray, onError:@escaping ErrorComplete){
    serverClientBaseAny(_url: SERVERBASEURL, params: nil, httpMethid: .get, onComplete: { (result) in
        
        print(result)
        onComplete([result])
    }) { (error : Error) in
        onError(error)
    }
}


