//
//  MazTVCell.swift
//  Maz-UICollection-Picker-V1
//
//  Created by Shaik abdul mazeed on 02/03/21.
//

import UIKit

class MazTVCell: UITableViewCell {
  
    @IBOutlet weak var TVImgV: UIImageView!
    
    @IBOutlet weak var firstName: UILabel!
    
    @IBOutlet weak var lastName: UILabel!
    
    @IBOutlet weak var DOB: UILabel!
    
    @IBOutlet weak var profession: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
