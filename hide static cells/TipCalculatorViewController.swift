//
//  TipCalculatorViewController.swift
//  hide static cells
//
//  Created by Charlie Hwang on 7/14/16.
//  Copyright © 2016 Peini Wo. All rights reserved.
//

import UIKit

class TipCalculatorViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var billField: UITextField!
    
    
    @IBOutlet weak var tipLabel: UILabel!
    
    
    @IBOutlet weak var totalLabel: UILabel!
    
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var toggle: UISwitch!
 
    @IBOutlet weak var averageLabel: UILabel!
    
    @IBOutlet weak var pickerTextField: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var dataSource: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.billField .becomeFirstResponder()
        
        let pickerView = UIPickerView()
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        pickerTextField.inputView = pickerView
        
        dataSource = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tipLabel.text = "0.00"
        totalLabel.text = "0.00"
        averageLabel.text = "0.00"
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerTextField.text = dataSource[row]
           
        return dataSource[row]
    }
    
   
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    let numberOfRowsAtSection: [Int] = [1, 3]

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var rows: Int = 0
        
        if section < numberOfRowsAtSection.count {
            rows = numberOfRowsAtSection[section]
        }
        
        return rows
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    

    
    @IBAction func calculateTip(sender: AnyObject) {
        
        let tipPercentages = [0.12, 0.15, 0.18, 0.2]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipLabel.text = "\(tip)"
        totalLabel.text = "\(total)"
        
        tipLabel.text = String(format: "%.2f", tip)
        totalLabel.text = String(format: "%.2f", total)
        
    }
    
    @IBAction func toggleValueChanged(sender: UISwitch) {
        tableView.reloadData()
    }
    
    var pickerVisible = false

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 1) {
            if indexPath.row == 3 {
                pickerVisible = !pickerVisible
                tableView.reloadData()
            }
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 1) {
            if indexPath.row == 1 && toggle.on == false {
                return 0.0
            }
            if indexPath.row == 2 {
                if toggle.on == false {
                    return 0.0
                }
                return 293.0
            }
           return 44.0
        }
        return 250.0
    }
    
    
    // Catpure the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        pickerTextField.text = dataSource[row]
        
        
        if let
            totalAmountStr:String = totalLabel.text,
            numOfPersonStr:String = pickerTextField.text,
            totalAmount:Double = Double(totalAmountStr),
            numOfPerson:Double = Double(numOfPersonStr) {
            
                averageLabel.text = String(format: "%.2f", totalAmount/numOfPerson)
        }
        
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
    }
 
}
