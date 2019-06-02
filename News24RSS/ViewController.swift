//
//  ViewController.swift
//  News24RSS
//
//  Created by Wafiq Salie on 2019/06/02.
//  Copyright © 2019 EndCrypt3d. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController {
    
    private var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    private var data = [RSSFeedResponse.Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView = UITableView(frame: .zero)
        self.tableView.rowHeight = 80
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "RSSFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "RSSFeedTableViewCell")
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(apiGetRSSFeed(_:)), for: .valueChanged)
        
        self.view.addSubview(tableView)
        
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        apiGetRSSFeed(self)
    }
    
    @objc private func apiGetRSSFeed(_ sender: Any) {
        let rssURL = URL(string: "https://api.rss2json.com/v1/api.json?rss_url=http://feeds.news24.com/articles/Fin24/Tech/rss")!
        
        Alamofire.request(rssURL, method: .get, parameters: nil).response { (responseData) in
            
            //let json = String(data: responseData.data!, encoding: .utf8)
            do{
                let feed = try JSONDecoder().decode(RSSFeedResponse.self, from: responseData.data!)
                self.data = feed.items
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.data[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RSSFeedTableViewCell") as? RSSFeedTableViewCell{
            cell.setData(data: item)
            return cell
        }else{
            return UITableViewCell(frame: .zero)
        }
    }
}

