//
//  MainTableViewCell.swift
//  KakaoBankTest
//
//  Created by KyungJun Jeong on 2017. 4. 14..
//  Copyright © 2017년 KyungJun Jeong. All rights reserved.
//

import UIKit
import SDWebImage

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImgView.clipsToBounds = true
        iconImgView.layer.cornerRadius = 10
    }

    func cellViewSetting(data:RankListDataModel) {
        
        rankLabel.text = "\(self.tag)"
        titleLabel.text = data.title
        iconImgView.sd_setImage(with: URL(string:data.image!), placeholderImage: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func getHeight() -> CGFloat {
        return 86
    }
}
