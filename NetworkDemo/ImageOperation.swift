import Foundation
import UIKit

class ImageOperation :Operation {
    
    var url :URL
    var tableView :UITableView
    var indexPath :IndexPath
    
    init(url :URL, tableView :UITableView, indexPath :IndexPath) {
        self.url = url
        self.tableView = tableView
        self.indexPath = indexPath
        super.init()
    }
    
    //main方式，預設情況下是執行在背景執行緒
    override func main() {
        
        if self.isCancelled {
            return
        }
        
        //下載照片，更新回cell
        if let imageData = try? Data(contentsOf: url) {
            DispatchQueue.main.async {
            //下載完成時，判斷該位置的cell是否在畫面上
                if let cell = self.tableView.cellForRow(at: self.indexPath) {
                //如果該位置在停留的位置上，cell則會有值，否則為空值
                cell.imageView?.image = UIImage(data: imageData)
                cell.setNeedsLayout()//通知layout重新排列，customcell不會有作用，另外寫
                }
            }
        }
        
    }
}
