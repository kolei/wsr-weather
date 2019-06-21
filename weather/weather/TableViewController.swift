//
//  TableViewController.swift
//  weather
//
//  Created by WSR on 6/20/19.
//  Copyright © 2019 WSR. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var cityList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //cityList.append("Москва")
        
        let savedList = UserDefaults.standard.stringArray(forKey: "cityList") ?? [String]()
        for city in savedList {
            cityList.append(city)
        }
//        URL(string: <#T##String#>)
//        Data(contentsOf: <#T##URL#>)
//        UIImage(data: <#T##Data#>)
//
        tableView.backgroundView = UIImageView.init(image: UIImage(named: "background3"))
        tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func addCity(_ sender: Any) {
        let alert = UIAlertController(title: "Добавление город", message: "Добавьте пожалуйста город!", preferredStyle: .alert)
        alert.addTextField { (textField) in }
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            self.cityList.append(textField.text!)
            UserDefaults.standard.set(self.cityList, forKey: "cityList")
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in }))
        
        self.present(alert, animated: true, completion: nil)

    }
    
    // переопределяем действие для удаления ячейки
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            cityList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaults.standard.set(self.cityList, forKey: "cityList")
            tableView.reloadData()
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cityList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! TableViewCell

        cell.cityLabel.text = cityList[indexPath.row]

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMain" {
            let vc = segue.destination as! ViewController
            let index = self.tableView.indexPathForSelectedRow
            vc.city = cityList[(index?.row)!]
            let userDefaults = UserDefaults()
            userDefaults.set(cityList[(index?.row)!], forKey: "lastCity")
        }
    }


}
