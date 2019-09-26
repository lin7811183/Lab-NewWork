//
//  ProfileViewController.swift
//  NetworkDemo
//
//  Created by Vincent on 2016/2/17.
//  Copyright © 2016年 Vincent. All rights reserved.
//

import UIKit

class ProfileViewController:  UITableViewController {
    
    
    var profiles : [Dictionary<String,String>]
    var async : Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        profiles = [["name":"Apple Store","URL":"https://graph.facebook.com/AppStore/picture?type=large"],
            ["name":"gaga","URL":"https://graph.facebook.com/ladygaga/picture?type=large"],
            ["name":"CSIMiami","URL":"https://graph.facebook.com/CSIMiami/picture?type=large"],
            ["name":"YahooTWNews","URL":"https://graph.facebook.com/YahooTWNews/picture?type=large"],
            ["name":"kanpai.fans","URL":"https://graph.facebook.com/kanpai.fans/picture?type=large"],
            ["name":"Apple Store","URL":"https://graph.facebook.com/AppStore/picture?type=large"],
            ["name":"gaga","URL":"https://graph.facebook.com/ladygaga/picture?type=large"],
            ["name":"CSIMiami","URL":"https://graph.facebook.com/CSIMiami/picture?type=large"],
            ["name":"YahooTWNews","URL":"https://graph.facebook.com/YahooTWNews/picture?type=large"],
            ["name":"kanpai.fans","URL":"https://graph.facebook.com/kanpai.fans/picture?type=large"],
            ["name":"Apple Store","URL":"https://graph.facebook.com/AppStore/picture?type=large"],
            ["name":"gaga","URL":"https://graph.facebook.com/ladygaga/picture?type=large"],
            ["name":"CSIMiami","URL":"https://graph.facebook.com/CSIMiami/picture?type=large"],
            ["name":"YahooTWNews","URL":"https://graph.facebook.com/YahooTWNews/picture?type=large"],
            ["name":"kanpai.fans","URL":"https://graph.facebook.com/kanpai.fans/picture?type=large"]];
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: IBAction
    @IBAction func sync(sender: AnyObject) {
        self.async = false
        self.title = "sync"
        self.tableView.reloadData()
    }
    
    @IBAction func async(sender: AnyObject) {
        self.async = true
        self.title = "async"
        self.tableView.reloadData()
    }
    //MARK: UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.profiles.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.profiles[indexPath.row]["name"]
        cell.imageView?.image = nil
        if let url = URL(string: self.profiles[indexPath.row]["URL"]!){
            if ( self.async ){
                DispatchQueue.global().async {
                    if let imageData = try? Data(contentsOf: url) {
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async(execute: { () -> Void in
                            if let  cell = tableView.cellForRow(at: indexPath){
                                cell.imageView?.image = image
                                cell.setNeedsLayout()
                            }
                        })
                    }
                }
            }else{
                if let imageData = try? Data(contentsOf: url),let image = UIImage(data: imageData){
                    cell.imageView?.image = image
                    cell.setNeedsLayout()
                }
            }
        }
        return cell;
    }

}
