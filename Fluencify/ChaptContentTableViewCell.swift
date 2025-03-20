//
//  ChaptContentTableViewCell.swift
//  Fluencify
//
//  Created by Iacopo Boaron on 23/02/2024.
//

import UIKit

class ChaptCTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var labelContent: UILabel!
    
    @IBOutlet weak var labelContent2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
