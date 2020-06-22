

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var articlesTableView: UITableView!
    fileprivate let viewModel = ViewControllerViewModel()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        viewModel.articleDelegate = self
        self.title = "ARTICLES"
        articlesTableView?.dataSource = viewModel
        articlesTableView?.delegate = viewModel
        articlesTableView?.rowHeight = UITableView.automaticDimension
        articlesTableView?.estimatedRowHeight = 296

        articlesTableView?.register(artInfoCell.nib, forCellReuseIdentifier: artInfoCell.identifier)

        fetchData();
   
    }
    
    func fetchData() {
        DataBaseManger.saveArticlesToDb {
            let articles = DataBaseManger.loadArticlesFromDb()
            self.viewModel.refreshWith(data: articles, {
                self.articlesTableView.reloadData()
            })
        }
    }

}


extension ViewController : articleInfoCellDelegate{
   
    func actionHandling(cell: artInfoCell) {
        fetchData()
    }
    // action handling in case of actionable item available.
}
