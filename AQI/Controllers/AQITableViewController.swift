//
//  AQITableViewController.swift
//  AQI
//
//  Created by sean on 2019/5/8.
//  Copyright © 2019 sean. All rights reserved.
//

import UIKit
import RealmSwift

class AQITableViewController: UITableViewController {

    var sites = ["台北","台中","高雄"]
    var aqi = ["123","23","23"]
    var status = ["普通","普通","普通"]
    let realm = try! Realm()
    
    @IBOutlet weak var headerViewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newAQI = AQIData()
        newAQI.site = "高雄"
        newAQI.aqi = 222
        newAQI.status = "普通"
        

    headerViewLabel.text = "我看過滿足如何讓人失去警覺，然後犯錯和失去機會。"

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sites.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "AQITableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AQITableViewCell else {
            fatalError("The dequeued cell is not an instance of AQITableViewCell.")
        }
        let AQIs = realm.objects(AQIData.self)
        cell.siteName.text = AQIs[indexPath.row].site
        cell.AQIValue.text = String(describing: AQIs[indexPath.row].aqi)
        cell.statusValue.text = AQIs[indexPath.row].status
        // Configure the cell...

        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            sites.remove(at: indexPath.row)
            aqi.remove(at: indexPath.row)
            status.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
