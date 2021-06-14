//
//  TrainViewController.swift
//  ptuBus
//
//  Created by rokong.me on 2021/06/14.
//

import UIKit
import SwiftyJSON
import Alamofire

class TrainViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    private let _transport:String = "bus"
    private let _type:String = "timetable"
    private let _cell_name:String = "cell"
    private var dataSource:JSON = []
    private var _page:Int = 1
    private var _pagination:Bool = false
    private var url:BuildURL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.url = BuildURL(transport: self._transport, type: self._type, page:self._page, parameter: URLQueryItem(name: "station_id",  value: "4000035"))
        self.fetchData(url:self.url.url)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
