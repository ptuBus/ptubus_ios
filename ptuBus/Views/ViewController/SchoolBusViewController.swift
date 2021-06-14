//
//  SchoolBusViewController.swift
//  ptuBus
//
//  Created by rokong.me on 2021/05/31.
//

import UIKit
import Alamofire
import SwiftyJSON

class SchoolBusViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let _transport:String = "school"
    private let _type:String = "timetable"
    private let _cell_name:String = "cell"
    private var _page:Int = 1
    private var _pagination:Bool = false
    private var dataSource:JSON = []
    private var url:BuildURL!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var goToSchoolButton: UIButton!
    @IBOutlet var goToStationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 60
        title = "스쿨버스"
        self.url = BuildURL(transport: self._transport, type: self._type, page:self._page, parameter: URLQueryItem(name: "way",  value: "U"))
        self.fetchData(url:self.url.url)
    }

    @IBAction func goToSchoolButton(_ sender: Any) {
        self._page = 1
        self.url = BuildURL(transport: self._transport, type: self._type, page:self._page, parameter: URLQueryItem(name: "way",  value: "U"))
        self.fetchData(url: self.url.url)
        self.goToSchoolButton.backgroundColor = UIColor(rgb:0x2195ff)
        self.goToStationButton.backgroundColor = UIColor(rgb: 0x65b5ff)
    }
    
    //URL을 빌드한 다음 Alamofire을 통하여 request를 하는 작업을 합니다.
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
    
    @IBAction func goToStationButton(_ sender: Any) {
        self._page = 1
        self.url = BuildURL(transport: self._transport, type: self._type, page:self._page, parameter: URLQueryItem(name: "way", value: "D"))
        self.fetchData(url: self.url.url)
        self.goToStationButton.backgroundColor = UIColor(rgb:0x2195ff)
        self.goToSchoolButton.backgroundColor = UIColor(rgb: 0x65b5ff)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SchoolBusTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SchoolBusTableViewCell", for: indexPath) as! SchoolBusTableViewCell
        cell.mainLabel.text = dataSource[indexPath.row]["schedule"].string
        cell.subLabel.text = dataSource[indexPath.row]["end_station_name"].string
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
