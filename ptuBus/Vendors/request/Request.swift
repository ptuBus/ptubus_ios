//
//  Request.swift
//  ptuBus
//
//  Created by rokong.me on 2021/06/07.
//

import Foundation
import Alamofire
import SwiftyJSON

class Request {
   class func getJSON(url: String, completion: ((JSON?) -> Void)?) {
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let resp):
                do {
                    try completion?(JSON(resp))
                } catch (let error) {
                    print (error.localizedDescription)
            }
            case .failure(let error):
                print (error.localizedDescription)
            }
        }
    }
}
