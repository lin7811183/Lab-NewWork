//
//  XMLParserViewController.swift
//  NetworkLab
//
//  Created by Vincent on 2016/2/18.
//  Copyright © 2016年 Vincent. All rights reserved.
//

import UIKit
import GDataXML_HTML

class XMLParserViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var mediaLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: IBAction
    @IBAction func parse(sender: AnyObject) {
        
        if let url = URL(string: "http://iosnetworkdemo.appspot.com/xml.jsp") {
            let request = URLRequest(url: url)
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) in
                if let e = error {
                    print("erroe \(e)")
                }
                guard let xmlData = data else {
                    return
                }
                do {
                    let doc = try GDataXMLDocument(data: xmlData)//根原樹
                    if let root = doc.rootElement() {
                        let node = root.attribute(forName: "status")
                        let status = node?.stringValue()
                        DispatchQueue.main.async {
                            self.statusLabel.text = status
                        }
                        if let mediaid = root.elements(forName: "mediaid")?.first as? GDataXMLElement {
                            let mID = mediaid.stringValue()
                            DispatchQueue.main.async {
                                self.mediaLabel.text = mID
                            }
                        }
                    }
                }catch {
                    print("error parsing xml \(error)")
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
