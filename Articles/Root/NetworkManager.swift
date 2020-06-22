

import Foundation
import Alamofire


/* Class dedicated to the Network layer */
enum ServiceType: URLConvertible{
    
    case serviceLoadArticles //Add more calls later
    
    func asURL() throws -> URL {
        return URL.init(string: self.URLString)!
    }
    var URLString : String{
        switch self{
        case .serviceLoadArticles:
            return "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?"
                //Add more if required
                // default://for future use - delete the default to suppress the warning
        }
    }
    var requestMethod : Alamofire.HTTPMethod{
        switch self{
        case .serviceLoadArticles:
            return .get
            //Add more if required
            //default: //for future use - delete the default to suppress the warning
            //return .get
        }
    }
    var headers:[String : String]{
        switch self{
        case .serviceLoadArticles:
            var values = ["Content-Type": "application/json"]
            values ["Accept-Encoding"] = "gzip"
            return values
            //Add more when required
            //default:
            //var values = ["Content-Type": "application/json"]
            //values ["Accept-Encoding"] = "gzip"
            //return values
        }
    }
}

class NetworkManger: NSObject {
    class func requestForType(page:Int32, serviceType : ServiceType, params:[String: Any]?, completionBlock :@escaping (_ response:Array<Any>?,_ error: NSError?) -> ()) {
        //TODO:CHECK FOR NETWORK CONNECTION USING REACHABILITY
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        let pageWithLimit = "page=\(page)&limit=10"
        Alamofire.request(serviceType.URLString + pageWithLimit, method: serviceType.requestMethod, parameters: params, encoding: URLEncoding.default, headers: serviceType.headers).responseJSON{ response in
            DispatchQueue.main.async() {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                print(response)
                switch response.result{
                case .success(let value):
                    if value is NSNull{
                        // SERVER MESS - SENDING NOTHING INSIDE SUCCESS
                        completionBlock(["success"], nil)
                        return
                    }
                    let responseValue = value as? Array<Any>
                    completionBlock(responseValue!, nil)
                case .failure(let error):
                    if (response.response?.statusCode == 304){
                        completionBlock(Array<Any>(), nil)
                    }else{
                        print(Error.self)
                        completionBlock(nil, error as NSError)
                        if error.localizedDescription == "cancelled" {
                        } else {
                            DispatchQueue.main.async() {
                                //Show aleart to the user
                            }
                        }
                    }
                }
            }
        }
    }
}
