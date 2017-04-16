//
//  RankDetailViewController.swift
//  KakaoBankTest
//
//  Created by KyungJun Jeong on 2017. 4. 15..
//  Copyright © 2017년 KyungJun Jeong. All rights reserved.
//

import UIKit

class RankDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var itemId:String?
    var detailData:RankDetailDataModel?
    var screenArray:NSArray = NSArray()
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    @IBOutlet weak var screenCollection: UICollectionView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var appInfoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        indicator.startAnimating()
        
        iconImgView.clipsToBounds = true
        iconImgView.layer.cornerRadius = 10
        
        NetworkManager().reqLookUp(itemId: itemId!, resSuccess: { (resSuccess) in
            
            self.viewSetting(data: (resSuccess?.detailModel)!)
            
            self.screenArray = (resSuccess?.detailModel?.screenShots)!
            self.screenCollection.reloadData()
            
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
        }) { (resFail) in
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewSetting(data:RankDetailDataModel) {
        
        titleLabel.text = data.title
        
        iconImgView.sd_setImage(with: URL(string: data.image!), placeholderImage: nil)
        
        let stringLength = NSString(string: data.rating!).length
        
        if stringLength == 1 {
            ratingLabel.text = "\(data.rating!).0 / 5.0"
        }
        else {
            ratingLabel.text = "\(data.rating!) / 5.0"
        }
        
        appInfoTextView.layer.borderWidth = 1

        appInfoTextView.text = data.appInfo
        

    }
    
    //MARK:- collection delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankDetailCollectionViewCell",for: indexPath) as! RankDetailCollectionViewCell
        
        cell.cellViewSetting(screenUrl: screenArray[indexPath.row] as! String)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
