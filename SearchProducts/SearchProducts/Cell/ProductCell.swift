//
//  ProductCell.swift
//  SearchProducts
//
//  Created by Roshan Dharpure on 30/08/23.
//

import UIKit

class ProductCell: UITableViewCell {
   @IBOutlet weak var labelTitle: UILabel!
   @IBOutlet weak var labelDescription: UILabel!
   @IBOutlet weak var labelPrice: UILabel!
   @IBOutlet weak var labelBrand: UILabel!
   @IBOutlet weak var labelRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// Update the table cell with data
    func setUpCellWith(product: Product) {
        labelTitle.text = product.title
        labelDescription.text = product.description
        labelPrice.text = String(describing: product.price)
        labelBrand.text = product.brand
        labelRating.text = String(describing: product.rating)
    }
    
}
