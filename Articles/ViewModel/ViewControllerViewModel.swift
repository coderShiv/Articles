

import Foundation
import UIKit


/*ViewController view model*/
class ViewControllerViewModel: NSObject {
    var items = [Any]()
    weak var articleDelegate: articleInfoCellDelegate?
    
    func refreshWith(data: Array<Any>, _ completionBlock : @escaping ()->()) {
        self.items = data
        completionBlock()
    }
}

extension ViewControllerViewModel: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        print("indexPath.row : \(indexPath.row)")
        let itm = item as? ArticleInfoViewModel
        print("name:    \(itm?.name)")
        if let cell = tableView.dequeueReusableCell(withIdentifier: artInfoCell.identifier, for: indexPath) as? artInfoCell {
                cell.item = item as? ArticleInfoViewModel
                cell.artDelegate = self
                return cell
            }
        return UITableViewCell()
    }
    
     func tableView(_ tableView: UITableView,
                            willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        if ((indexPath.row + 1)%10 == 0){
            actionHandling(cell: cell as! artInfoCell)
        }
        
    }
}

extension ViewControllerViewModel : articleInfoCellDelegate{
    func actionHandling(cell:artInfoCell){
        self.articleDelegate?.actionHandling(cell: cell)
    }
}


/* Cell view model */
// MARK: - WelcomeElement
class ArticleInfoViewModel: NSObject {
    
    let id, avatar, designation ,createdAt, content: String?
    let comments, likes: Int32?
    let name: String?
    let image: String?
    let url:String?
    let title:String?
    
    init?(data: Article) { //Can add any thing extra which is needed for UI population like - section titles etc.
        self.id = data.id
        self.createdAt = data.createdAt
        self.content = data.content
        self.comments = data.comments
        self.likes = data.likes
        self.name = data.name
        self.image = data.image
        self.url = data.url
        self.title = data.title
        self.avatar = data.avatar
        self.designation = data.designation
    }

    
}

