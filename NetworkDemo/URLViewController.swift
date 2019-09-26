//
//  URLViewController.swift
//  NetworkDemo
//
//  Created by Vincent on 2016/2/17.
//  Copyright © 2016年 Vincent. All rights reserved.
//

import UIKit

class URLViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dict :[String:Any] = [:]
        dict["classname"] = "ios網路應用課程"
        dict["hours"] = NSNull()
        dict["started"] = true
        dict["address"] = ["streetAddress":"復興南路一段390號","city":"台北市","postalCode":"100"]
        dict["phoneNumber"] = [["type":"office","number":"02-6632-6599"],["type":"home","number":"02-1111-2222"]]
        
        if let data = try? JSONSerialization.data(withJSONObject: dict, options: [.prettyPrinted]) {
            if let jsonString = String(data: data, encoding: .utf8) {
                print(jsonString)
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: IBAction
    @IBAction func connect(sender: AnyObject) {
        
        //google geocode URL: https://iosnetworkdemo.appspot.com/address.jsp?address=
        //facebook profile image URL: http://graph.facebook.com/AppStore/picture?type=large
        
//        if let imagaURL = URL(string: "http://graph.facebook.com/AppStore/picture?type=large") {
//                DispatchQueue.main.async {
//                    if let imageData = try? Data(contentsOf: imagaURL) {
//                        let image = UIImage(data: imageData)
//                        let imageView = UIImageView(image: image)
//                        self.view.addSubview(imageView)
//                    }
//            }
        
        
//        //中文轉utf-8
//        var address = "台北市"
//        address = address.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
//
//        if let url = URL(string: "https://iosnetworkdemo.appspot.com/address.jsp?address=\(address)") {
//            do {
//                //let content = try? String(contentsOf: url)
//                //datatype
//                if let geoData = try? Data(contentsOf: url) ,
//                    let jsonData = try? JSONSerialization.jsonObject(with: geoData, options: [])as! Dictionary<String,Any> ,
//                    let result = jsonData["results"]as? [Any] ,
//                    let firstResult = result.first as? [String:Any] ,
//                    let geometry = firstResult["geometry"] as? [String:Any],
//                    let location = geometry["location"] as? [String:Double]{
//                        let textView = UITextView(frame:  self.view.bounds)//偷懶不用autolayout
//                        textView.text = "\(location["lat"]!),\(location["lng"]!)"
//                        self.view.addSubview(textView)
//                    }
//                    //let textView = UITextView(frame:  self.view.bounds)//偷懶不用autolayout
//                    //textView.text = content
//                    //self.view.addSubview(textView)
//            }catch {
//                print("error : \(error)")
//            }
//        }
        
        //URL Session
        if let imagaURL = URL(string: "http://graph.facebook.com/AppStore/picture?type=large") {
            
            let request = URLRequest(url: imagaURL)
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
            
            let task = session.dataTask(with: request) { (data, response, error) in
                
                if let e = error {
                    print("error : \(error)")
                }
                guard let imageData = data else {
                    return
                }
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData)
                    let imageView = UIImageView(image: image)
                    self.view.addSubview(imageView)
                }
            }
            task.resume()
            
        }
            
        
        
        
        
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
