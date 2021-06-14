//
//  ExpressBusViewController.swift
//  ptuBus
//
//  Created by rokong.me on 2021/06/14.
//

import UIKit
import SwiftyJSON
import Alamofire

class ExpressBusViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
        title = "시외버스"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.url = BuildURL(transport: self._transport, type: self._type, page:self._page, parameter: URLQueryItem(name: "station_id",  value: "4000035"))
        self.fetchData(url:self.url.url)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SchoolBusTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SchoolBusTableViewCell", for: indexPath) as! SchoolBusTableViewCell
        cell.mainLabel.text = dataSource[indexPath.row]["schedule"].string
        cell.subLabel.text = dataSource[indexPath.row]["bus_terminal"]["end_station_name"].string
        return cell
    }
    
    private func fetchData(url:String) {
        Request.getJSON(url: url) { json in
            if let json = json {
                self.dataSource = json["results"]
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                fatalError()
            }
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        // 스크롤이 테이블 뷰 Offset의 끝에 가게 되면 다음 페이지를 호출
        if offsetY > (contentHeight - height) {
            self.url.page = 1
            self._pagination = true
            if (self._pagination) {
                Request.getJSON(url: self.url.url) { json in
                    if let json = json {
                        if json["results"] != JSON.null {
                            do {
                                try self.dataSource = self.dataSource.merged(with: json["results"])
                            } catch {
                                print("error")
                            }
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    } else {
                        print("error")
                    }
                }
            }
        }
    }
    
}
