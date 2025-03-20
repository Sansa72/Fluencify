//
//  ChaptersTableViewCell.swift
//  Fluencify
//
//  Created by Iacopo Boaron on 19/02/2024.
//

import UIKit

class ChaptersTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var chaptersLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
