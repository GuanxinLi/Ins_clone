//
//  PostTableViewCell.swift
//  Ins_clone
//
//  Created by Guanxin Li on 2/26/18.
//  Copyright © 2018 Guanxin. All rights reserved.
//

import UIKit
import Parse

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var photoView: PFImageView!
    
    
    var insPost: Post! {
        didSet {
            self.photoView.file = insPost["media"] as? PFFile
            self.userLabel.text = insPost["caption"] as? String
            self.photoView.load { (image, error) in
                if let image = image {
                    print ("ohhhhh image! :DD")
                    self.photoView.image = image 
                } else {
                    print(error)
                }
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
