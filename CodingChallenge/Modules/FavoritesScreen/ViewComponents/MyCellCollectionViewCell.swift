//
//  MyCellCollectionViewCell.swift
//  CodingChallenge
//
//  Created by 01HW1928584 on 05/06/22.
//

import UIKit

class MyCellCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var lblDate: UILabel!
    
    // MARK: - SettingData
    func settingData(from: APIServiceResponse) {
//        lblDate.text = from.date
        imageView.loadImage(withUrl: from.url )
    }
    // MARK: - Nib Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView?.frame.size.width = 100.0
        imageView?.frame.size.height = 100.0
        imageView?.isHidden = false
        imageView.contentMode = .scaleAspectFit
    }
    static func nib() -> UINib {
        UINib(nibName: String(describing: MyCellCollectionViewCell.self), bundle: nil)
    }
    
}
