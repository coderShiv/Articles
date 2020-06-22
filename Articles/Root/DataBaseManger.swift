

import Foundation
import UIKit

/* Class dedicated to the Database related things */
class DataBaseManger: NSObject {
    
    class func saveArticlesToDb(_ completionBlock : @escaping ()->()) {
        
        var page:Int32 = 0 , limit:Int32 = 10 ;
        
       let articles =  loadArticlesFromDb()
        if articles.isEmpty{
            page = 1 ;
        }else {
          page = (Int32(articles.count)/limit) + 1  ;
        }
        ServiceManager.loadArticles(page:page) { (response, error) in
            if response != nil {
                //TODO - Use background context to improve performance
                let context = CoreDataStack.persistentContainer.viewContext
                for dictionary in response! {
                    let art = Article(context:context)
                    art.parseWith(response: dictionary as! [String : Any])
                }
                //TODO - we can use background context if data is huge...
                CoreDataStack.saveContext()
                completionBlock()
            }else{
                
            }
            if error != nil {
                //Show error
            }
        }
        
    }
    
    class func loadArticlesFromDb() -> [ArticleInfoViewModel] {
        let context = CoreDataStack.persistentContainer.viewContext
        var viewModelArray = [ArticleInfoViewModel]()
        do {
            let articles : [Article] = try context.fetch(Article.fetchRequest())
            if articles.count > 0{
                for article in articles{
                    
                    let viewModel = ArticleInfoViewModel(data: article)
                    viewModelArray.append(viewModel!)
                }
            }
        }catch {
            print("Error fetching data from CoreData")
        }
        return viewModelArray
    }
    //Add other methods when needed
}

