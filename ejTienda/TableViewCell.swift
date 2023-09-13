//
//  TableViewCell.swift
//  ejTienda
//
//  Created by AlumnoPro on 30/09/2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var producto: UILabel!
    @IBOutlet weak var precio: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
