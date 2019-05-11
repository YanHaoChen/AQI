//
//  AQITableViewController.swift
//  AQI
//
//  Created by sean on 2019/5/8.
//  Copyright © 2019 sean. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftSoup

class AQITableViewController: UITableViewController {
    let AQITop3: String = "https://opendata.epa.gov.tw/webapi/Data/REWIQA/?$orderby=SiteName&$skip=0&$top=3&format=json"
    
    let dailyQuote: String = "https://tw.appledaily.com/index/dailyquote"
    let realm = try! Realm()
    
    @IBOutlet weak var headerViewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let httpClent = HttpClient(session: URLSession(configuration: URLSessionConfiguration.default))
        
        let AQITop3Url = URL(string: AQITop3)
        httpClent.get(url: AQITop3Url!) { (data, response, error) in
            if data != nil {
                let top3AQIJson = dataToJsonArray(data: data!)
                for AQIResult in top3AQIJson {
                    let newAQI = AQIData()
                    newAQI.site = AQIResult["SiteName"] as! String
                    newAQI.aqi = Double(AQIResult["AQI"] as! String) ?? 0.0
                    newAQI.status = AQIResult["Status"] as! String
                    try! self.realm.write {
                        self.realm.add(newAQI)
                    }
                }
                let AQIs = self.realm.objects(AQIData.self)
                print(AQIs.count)
                self.tableView.reloadData()

            }
        }
        
        let dailyQuoteUrl = URL(string: dailyQuote)
        let fadeAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36"
        let headers = ["User-Agent":fadeAgent]

        httpClent.get(url: dailyQuoteUrl!, headers: headers) { (data, response, error) in
            let htmlbody = dataToString(data: data)
            do {
                let doc: Document = try SwiftSoup.parse(htmlbody)
                let quote: Element = try doc.select("article").get(1)
                let quoteText: String = try quote.text()
                DispatchQueue.main.async {
                    self.headerViewLabel.text = quoteText
                }
            } catch Exception.Error(let type, let message) {
                print("type:\(type), massage:\(message)")
            } catch {
                print("error")
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let AQIs = realm.objects(AQIData.self)
        return AQIs.count
        
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
            let AQIs = realm.objects(AQIData.self)
            try! self.realm.write {
                self.realm.delete(AQIs[indexPath.row])
            }
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
