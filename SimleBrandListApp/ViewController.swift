//
//  ViewController.swift
//  SimleBrandListApp
//
//  Created by Semih Ekmen on 2.03.2023.
//


/*
In this app, we gonna see the some important features at the below. These are:

-   Detecting Application Icon
-   TableView   

----------------------------------------------------
    SETTING UP THE APP ICON 
    every app has icon as you know. IN the IOS, we can detect from right panel. There is a asset file on the panel. We have already used that if you 
    remember. So, go to the asset file. you will see the all size of app placeholder. 

    under the line, there is a description of the where icon will use. notification,settigns,spotlight etc. for iphone,ipad,ipod. Also, there is a 
    measure and value of enlargeing property. For example, 20pt and 2x or 3x. its meaing is icon's size must be 40*40 or 60*60 square.

    if you don't setting up inconvenient icon to asset file, xCode will warn you.
----------------------------------------------------
    TABLEVIEW

    [DESCRIPTION]
    tableView is kind of the views of IOS. If you remember the collecctionView from previous repo,tableview is similar to collectionview.
    
    [USAGE] 
    -add the tableView from libray. (There are 2 choice to use it. TableView and TableViewController. For now, we gonna use the tableView only. In the
    progres, we gonna see how to use it) 
    - when we use the only tableView, adjust the constaints.(you can click the reset to suggestions from const menu simply.)
    - connect the tableView to your viewController and inherit its required or not required functions.(For doing that you have to inheritance 2 
    class. These are UITableViewDataSource and UITableViewDelegate and configuration your tableViw (CHECKPOINT 1))
    - so, we need to data source for listing items with tableView. In this reason,create a data source.(CHECKPOINT 2)
    - collectionView function which include numberOfRowsInSection parameter, represent to how many row will seem on the screen.(CHECLPOINT 3)
    - collectionView function which include cellForRowAt, incluide the related row all properties. It is similar to ListTile function from Flutter.
    (in this function give us label from default and other features.)(CHECKPOINT 4)
    - 
*/

import UIKit

class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {//CHECKPOINT 1

    @IBOutlet weak var myTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assingDelegated()  // CHECKPOINT 1
    }
    
    fileprivate func assingDelegated() {
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {   //CHECKPOINT 3
        return Repo.shared.brands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {  //CHECKPOINT 4
        let cell:UITableViewCell = UITableViewCell()                  // we have created TableViewCell object to use it on our table.
        cell.textLabel?.text = Repo.shared.brands[indexPath.row]      // that cell has default label,
        return cell
    }
}


class Repo{
    private init(){}
    static var shared:Repo = Repo()
    var brands:[String] = ["Lamborghini","Maserati","Ferrari","Fiat"]  //CHECKPOINT2
}

