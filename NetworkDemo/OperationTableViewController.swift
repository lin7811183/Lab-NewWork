//
//  OperationTableViewController.swift
//  NetworkDemo
//
//  Created by Vincent on 2016/2/17.
//  Copyright © 2016年 Vincent. All rights reserved.
//

import UIKit

class OperationTableViewController: UITableViewController {
    
    let queue = OperationQueue()
    //let queue = OperationQueue().main(主執行緒)
    
    var profiles : [Dictionary<String,String>]
    required init?(coder aDecoder: NSCoder) {
        
        queue.maxConcurrentOperationCount = 1 //同時間下載最大次數
        
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    //MARK: UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.profiles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.profiles[indexPath.row]["name"]
        cell.imageView?.image = nil //因為cell有reuser機制，所以當tableView上滑下滑cell移除畫面再利用時，會有照片重複到利用上離開畫面的cell，所以要清空離開畫面的cell
        if let url = URL(string: self.profiles[indexPath.row]["URL"]!){
            /*
            //不能取消！！這機制不能用，會一直下載(ＧＣＤ下載圖片在tableView不能用)
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        //下載完成時，判斷該位置的cell是否在畫面上
                        if let cell = tableView.cellForRow(at: indexPath) {
                            //如果該位置在停留的位置上，cell則會有值，否則為空值
                            cell.imageView?.image = UIImage(data: imageData)
                            cell.setNeedsLayout()//通知layout重新排列，customcell不會有作用，另外寫
                        }
                    }
                }
            }*/
        
            let operation = ImageOperation(url: url, tableView: tableView, indexPath: indexPath)
            operation.url = url
            operation.tableView = tableView
            operation.indexPath = indexPath
            queue.addOperation(operation)
            
            
            
        }
        return cell;
    }
    //cell要離開畫面時，會被呼要的func
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //相同位置的operation cancel掉，因為已經離開畫面
        self.queue.operations.filter { (op) -> Bool in
            let imageOperation = op as! ImageOperation
            //如果離開位置cell一樣，則取消，indexPath的比較使用compare方法，相等回傳orederSame
            if imageOperation.indexPath.compare(indexPath) == .orderedSame {
                //imageOperation.cancel()
                return true
            }
            return false
        }.first?.cancel()
        /*
        for operation in self.queue.operations {
            let imageOperation = operation as! ImageOperation
            if imageOperation.indexPath.compare(indexPath) == .orderedSame {
                imageOperation.cancel()
                break
            }
        }*/
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
