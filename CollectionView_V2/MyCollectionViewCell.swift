//
//  MyCollectionViewCell.swift
//  CollectionView_V2
//
//  Created by Felipe Ignacio Zapata Riffo on 05-08-21.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView:UIImageView?
    override func awakeFromNib() {
        imageView?.contentMode = .scaleAspectFit
        
        super.awakeFromNib()
        // Initialization code
    }
    
}
