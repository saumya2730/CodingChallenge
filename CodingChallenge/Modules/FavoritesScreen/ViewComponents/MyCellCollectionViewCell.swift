//
//  MyCellCollectionViewCell.swift
//  CodingChallenge
//
//  Created by 01HW1928584 on 05/06/22.
//

import UIKit

class MyCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func settingData(from: APIServiceResponse) {
        imageView.loadImage(withUrl: from.url )
        imageView.contentMode = .center
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView?.frame.size.width = 100.0
        imageView?.frame.size.height = 100.0
//        notNetworkLbl?.isHidden = true
        imageView?.isHidden = false
    }
    static func nib() -> UINib {
        UINib(nibName: String(describing: MyCellCollectionViewCell.self), bundle: nil)
    }
    
}
