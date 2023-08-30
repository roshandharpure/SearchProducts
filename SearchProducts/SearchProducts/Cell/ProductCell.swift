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
    }
    
    /// Update the table cell with data
    func setUpCellWith(product: Products) {
        labelTitle.text = product.title
        labelDescription.text = product.description
        
        if let brand = product.brand {
            labelBrand.text = Constants.ProductCellText.brand + brand
        } else {
            labelBrand.text = Constants.ProductCellText.brand + Constants.ProductCellText.na
        }
        
        if let rating = product.rating {
            labelRating.text = Constants.ProductCellText.rating + " \(rating)"
        } else {
            labelRating.text = Constants.ProductCellText.rating + Constants.ProductCellText.na
        }
        
        if let price = product.price {
            labelPrice.text = Constants.ProductCellText.price + " $\(price)"
        } else {
            labelPrice.text = Constants.ProductCellText.price + Constants.ProductCellText.na
        }
    
    }
    
}
