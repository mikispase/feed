//
//  NetworkManager.swift
//  test
//
//  Created by Dimitar Spasovski on 4/8/19.
//  Copyright © 2018 Dimitar Spasovski. All rights reserved.
//

import Foundation
import Alamofire

typealias postMethodInput = (Dictionary<String,Any>)

let headers: HTTPHeaders = [
    "Accept": "application/json"
]

func responseResult(response:DataResponse<Any>,onComplete:@escaping CompletitionDictonary, onError:@escaping ErrorComplete) {
    switch response.result{
    case .success(let data):
        onComplete(data as! Dictionary<String, Any>)
        break
    case .failure(let error):
        onError(error)
        break
    }
}

func responseResultArray(response:DataResponse<Any>,onComplete:@escaping Completition, onError:@escaping ErrorComplete) {
    switch response.result{
    case .success(let data):
        onComplete(data as! Array<Any>)
        break
    case .failure(let error):
        onError(error)
        break
    }
}

func responseResultAny(response:DataResponse<Any>,onComplete:@escaping Completition, onError:@escaping ErrorComplete) {
    switch response.result{
    case .success(let data):
        onComplete(data as Any)
        break
    case .failure(let error):
        onError(error)
        break
    }
}



func serverClientBase(_url:String,params:Dictionary<String,Any>?,httpMethid:HTTPMethod,onComplete:@escaping CompletitionDictonary, onError:@escaping ErrorComplete) {
    Alamofire.request(URL(string: _url)!,
                      method: .get,
                      parameters: params,
                      encoding: JSONEncoding.default,
                      headers: headers).responseJSON { (response) in
        responseResult(response: response, onComplete: { (responeseDictonary) in
            onComplete(responeseDictonary)
        }, onError: { (error) in
            onError(error)
        })
    }
}

func serverClientBaseArray(_url:String,params:Dictionary<String,Any>?,httpMethid:HTTPMethod,onComplete:@escaping Completition, onError:@escaping ErrorComplete) {
    Alamofire.request(URL(string: _url)!, method: .get, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
        responseResultArray(response: response, onComplete: { (responeseArray) in
            onComplete(responeseArray)
        }, onError: { (error) in
            onError(error)
        })
    }
}

func serverClientBaseAny(_url:String,params:Dictionary<String,Any>?,httpMethid:HTTPMethod,onComplete:@escaping Completition, onError:@escaping ErrorComplete) {
    Alamofire.request(URL(string: _url)!, method: .get, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
        responseResultAny(response: response, onComplete: { (responeseArray) in
            onComplete(responeseArray)
        }, onError: { (error) in
            onError(error)
        })
    }
}




extension Dictionary {
    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    func printJson() {
        print(json)
    }
    
}
