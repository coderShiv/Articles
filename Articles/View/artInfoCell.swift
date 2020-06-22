

import UIKit
import AlamofireImage

protocol articleInfoCellDelegate: class{
    func actionHandling(cell:artInfoCell)
}

class artInfoCell: UITableViewCell {
    
    @IBOutlet weak var outletAvatar: UIImageView!
    @IBOutlet weak var outletUserName: UILabel!
    @IBOutlet weak var outletUserDesignation: UILabel!
    @IBOutlet weak var outletTimeRemaing: UILabel!
    @IBOutlet weak var outletArticleImage: UIImageView!
    @IBOutlet weak var outletContent: UILabel!
    @IBOutlet weak var outletTitle: UILabel!
    @IBOutlet weak var outleArticleUrl: UIButton!
    @IBOutlet weak var outletLike: UILabel!
    @IBOutlet weak var outletComment: UILabel!
    
    weak var artDelegate: articleInfoCellDelegate?

    var item: ArticleInfoViewModel? {
        didSet {
            outletUserName?.text = item?.name
            outletLike?.text = "\(item?.likes ?? 0)"
            outletComment?.text = "\(item?.comments ?? 0)"
            outletUserDesignation.text = item?.designation
            outletTitle?.text = item?.title
            outletContent?.text = item?.content
            outleArticleUrl.setTitle(item?.url, for: .normal)
            
           if let time = item?.createdAt {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.date(from:time)!
            outletTimeRemaing.text = timeAgoSinceDate(date: date, numericDates: true)
            }
            
            if let url = item?.avatar {
                outletAvatar.af_setImage(withURL: NSURL(string: url)! as URL)
            }
            if let url = item?.image {
                outletArticleImage.isHidden = false
                outletArticleImage.af_setImage(withURL: NSURL(string: url)! as URL)
            }else {
                outletArticleImage.isHidden = true
            }
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        outletAvatar?.layer.cornerRadius = outletAvatar.frame.width/2
        outletAvatar?.clipsToBounds = true
        outletAvatar?.contentMode = .scaleAspectFit
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        outletAvatar?.af_cancelImageRequest()
        outletArticleImage?.af_cancelImageRequest()
        outletAvatar?.image = nil
        outletArticleImage?.image = nil
        
        outletUserName?.text = nil
        outletLike?.text = nil
        outletComment?.text = nil
        outletUserDesignation.text = nil
        outletTitle?.text = nil
        outletContent?.text = nil
        outleArticleUrl.titleLabel?.text = nil
        outletTimeRemaing.text = nil
    }
}

