//
//  FeedCell.swift
//  Feed
//
//  Created by Dimitar Spasovski on 4/8/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

import UIKit
import SDWebImage

class FeedCell: UITableViewCell {

    @IBOutlet var lblName: UILabel!
    
    @IBOutlet var lblDate: UILabel!
    
    var index: NSIndexPath!
    
    override func awakeFromNib(){
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateDataForCell(feeds : FeedRealm, indexPath : NSIndexPath) {
        index = indexPath
        lblDate.text = feeds.eventDate
        lblName.text = feeds.venueName
    }
}
