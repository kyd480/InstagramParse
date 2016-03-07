//
//  PostCell.swift
//  InstagramParse
//
//  Created by Kevin Duong on 3/6/16.
//  Copyright © 2016 Kevin Duong. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostCell: UITableViewCell {

    @IBOutlet weak var displayImageView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var post: PFObject! {
        didSet {
            self.displayImageView.file = post["media"] as? PFFile
            self.displayImageView.loadInBackground()
            captionLabel.text = post["caption"] as? String
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
