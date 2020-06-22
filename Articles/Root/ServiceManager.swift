

import Foundation

/* Class dedicated to the service layer */
class ServiceManager: NSObject {
    class func loadArticles (page:Int32, _ completionBlock : @escaping (_ responseArray:Array<Any>?, _ errorObj : NSError?)->()) {
        NetworkManger.requestForType(page:page, serviceType: ServiceType.serviceLoadArticles, params: nil) { (response, error) in
            if let error = error {
                completionBlock(nil, error)
            }else if let response = response {
                completionBlock(response, nil)
            }
        }
    }
}
