//
//  TableViewCell.swift
//  Fluencify
//
//  Created by Iacopo Boaron on 20/12/2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    let separatorView = UIView()
      let selectionBorderView = UIView() // A new view to handle the selection border

      override func awakeFromNib() {
          super.awakeFromNib()
          // Initialization code
          hideSelectionBorder()
          
          // Setup the separator view
          separatorView.backgroundColor = UIColor(red: 26/255, green: 26/255, blue: 26/255, alpha: 1) // Set the desired color
          contentView.addSubview(separatorView)
          
          // Setup the selection border view
          selectionBorderView.layer.borderWidth = 2.0
          selectionBorderView.layer.borderColor = UIColor.systemTeal.cgColor
          selectionBorderView.backgroundColor = .clear
          selectionBorderView.isUserInteractionEnabled = false
          contentView.addSubview(selectionBorderView)
          contentView.sendSubviewToBack(selectionBorderView) // Ensure the border view is behind other content
      }

      override func layoutSubviews() {
          super.layoutSubviews()
          let separatorHeight = CGFloat(10) // Adjust as needed
          separatorView.frame = CGRect(x: 0, y: self.contentView.frame.size.height - separatorHeight, width: self.contentView.frame.size.width, height: separatorHeight)
          
          // Adjust the selectionBorderView to not cover the separator
          selectionBorderView.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height - separatorHeight)
      }
      
      func showSelectionBorder() {
          selectionBorderView.isHidden = false
      }
      
      func hideSelectionBorder() {
          selectionBorderView.isHidden = true
      }

      override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)
          
          // When a cell is selected, show the border; otherwise, hide it.
          if selected {
              showSelectionBorder()
          } else {
              hideSelectionBorder()
          }
      }
    
}
