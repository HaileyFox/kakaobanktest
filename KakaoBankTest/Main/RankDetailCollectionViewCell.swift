//
//  RankDetailCollectionViewCell.swift
//  KakaoBankTest
//
//  Created by KyungJun Jeong on 2017. 4. 16..
//  Copyright © 2017년 KyungJun Jeong. All rights reserved.
//

import UIKit

class RankDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var screenImageView: UIImageView!
    
    func cellViewSetting(screenUrl:String) {
        screenImageView.sd_setImage(with: URL(string:screenUrl), placeholderImage: nil)
    }
}
