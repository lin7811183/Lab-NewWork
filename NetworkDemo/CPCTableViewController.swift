import UIKit
import GDataXML_HTML

class CPCTableViewController: UITableViewController {
    
    var doc: GDataXMLDocument?
    var stations: [GDataXMLElement]?
    var data:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        if let url = URL(string: "https://quality.data.gov.tw/dq_download_xml.php?nid=6065&md5_url=911fbd1ed38fd9e30cfea580ee3ed795") {
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
                    self.doc =  try GDataXMLDocument(data: xmlData)
                    //開始搜尋xml treez
                    self.stations = self.doc?.rootElement()?.elements(forName: "row") as? [GDataXMLElement]//加油站資料
                    
                    let fistStationName = self.stations?[1].elements(forName: "Col3")?[0] as? GDataXMLElement

                    
                    DispatchQueue.main.async {
                        //後面才取得資料，必須喝叫reloadData，不然tableView不會更新
                        self.tableView.reloadData()
                    }
                    
                    
                }catch {
                    print("error while pasing xml \(error)")
                }
                
                
            }
            task.resume()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let stations = self.stations {
            return stations.count
        }
        //return self.stations?.count ?? 0
        //return self.data.count
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        if let station = self.stations?[indexPath.row] ,
           let name = station.elements(forName: "Col3")[0] as? GDataXMLElement ,
           let tel = station.elements(forName: "Col7")[0] as? GDataXMLElement {
            cell.textLabel?.text = name.stringValue()
            cell.detailTextLabel?.text = tel.stringValue()
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
