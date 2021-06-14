//
//  BuildURL.swift
//  ptuBus
//
//  Created by rokong.me on 2021/06/06.
//

import Foundation

class BuildURL{
    private let _BASE_URL:String = "http://ptubus.com/v2/"
    private var _transport:String!
    private var _type:String!
    private var _page:Int!
    private var _parameter:Array<URLQueryItem>!

    init(transport:String, type:String, page:Int, parameter:URLQueryItem ...) {
        self._transport = transport
        self._type = type
        self._page = page
        self._parameter = parameter
    }
    
    public var page:Int {
        get{
            return self._page
        }
        set(value){
            self._page += value
        }
    }
    
    public var url:String {
        get{
            var urlComponents = URLComponents()
            urlComponents.scheme = "http"
            urlComponents.host = "ptubus.com"
            urlComponents.path = "/v2/" + self._transport + "/" + self._type + "/"
            
            urlComponents.queryItems = self._parameter
            urlComponents.queryItems?.append(URLQueryItem(name: "page", value: String(self._page)))

            if let url = urlComponents.string {
                return url
            } else {
                fatalError()
            }
        }
    }
}
