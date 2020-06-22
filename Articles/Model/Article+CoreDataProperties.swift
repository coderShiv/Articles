

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var comments: Int32
    @NSManaged public var content: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var likes: Int32
    @NSManaged public var name: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var avatar: String?
    @NSManaged public var designation: String?


func parseWith(response:[String:Any]){
    if response["id"] != nil {
            self.id = response["id"] as? String
    }
    if response["createdAt"] != nil {
            self.createdAt = response["createdAt"] as? String
    }
    if response["content"] != nil {
            self.content = response["content"] as? String
    }
    if response["comments"] != nil {
            self.comments = response["comments"] as? Int32 ?? 0
    }
    if response["likes"] != nil {
            self.likes = response["likes"] as? Int32 ?? 0
    }
    
    if let usr = response["user"] as? [[String:String]], !usr.isEmpty, let nme = usr[0]["name"] {
            self.name = nme
    }
    
    if let usr = response["user"] as? [[String:String]], !usr.isEmpty, let avatar = usr[0]["avatar"] {
        self.avatar = avatar
    }
    
    if let usr = response["user"] as? [[String:String]], !usr.isEmpty, let designation = usr[0]["designation"] {
        self.designation = designation
    }
    
    if let media = response["media"] as? [[String:String]], !media.isEmpty, let image = media[0]["image"] {
            self.image = image
    }
    
    if let media = response["media"] as? [[String:String]], !media.isEmpty, let title = media[0]["title"] {
            self.title = title
    }
    if let media = response["media"]  as? [[String:String]], !media.isEmpty, let url = media[0]["url"] {
            self.url = url
        }
    }
}
