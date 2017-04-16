//
//  MainTableViewController.swift
//  KakaoBankTest
//
//  Created by KyungJun Jeong on 2017. 4. 14..
//  Copyright © 2017년 KyungJun Jeong. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    var dataArray:NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager().reqTopfreeapplications(resSuccess: { (resSuccess) in
            self.dataArray = (resSuccess?.resultArray)!
            
            self.tableView.reloadData()
        }) { (resFail) in
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        
        cell.tag = indexPath.row + 1
        cell.cellViewSetting(data: dataArray[indexPath.row] as! RankListDataModel)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MainTableViewCell.getHeight()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let data = dataArray[indexPath.row] as! RankListDataModel
        let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RankDetailViewController") as! RankDetailViewController
        detailViewController.itemId = data.itemId
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
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
