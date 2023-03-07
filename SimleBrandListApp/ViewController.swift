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
-   SystemDefault(Same as shared_prefences)
-   LifeCycle
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
    - From here on, we gonna deeplye review the tableStack properties. static and dynamic choice. its difference similar to listView and listView.builder
    - there is cell field as CollectionView. click the cell and enter the identifier.
    - if you want to use appbar with TableView, you can add navigationController and set up the features.(you can set up without storyboard.CHECKPOINT5)
    NOTE:from here on, we gonna add the new brand on tableView and more features of alert.
    - create a function that add new brand your repo list and table.(if you use the 0 for all fields,it will comes on the top of the list.)(CHECKPOINT6)
    - now, we should create a alert diaog for take the brand name with textField. (CHECKPOINT7)
    - we gonna do delete operation. For that, add the button on anywhere(will add the barButton). After that we need to 2 function. These are
    setEditing(CHEKPOINT 7) and tableView with editingStyle without return(CHECKPOINT 8).
    NOTE: we could make button manuelly instead of the storyboard. Look at the (CHECKPOINT 9)
    NOTE: we could avoid the adding brand interaction when edit mode is open. So, it would be more safety. (CHECKPOINT 10)
    - in additionally,there is a function like onClicked. it's tableView with didSelectRowAt function. (CHECKPOINT 14)
 
 
    SYSTEMDEFAULT
    [DESCRIPTION]
    it is kind of little database like shared_prefences on Flutter. Developer can save or load small values. The Goal is save the bacis user inte-
    ractions. For instance, you can save theme proporty,is login or is first time open app etc. you shouldn't use for big and important values.
    
    [USAGE]
    - you can create a fucntion that include SystemDefault fucntions.
    to save value -----> UserDefault.standart.set(forKey: "any key")   //CHECKPOINT 12
    to load value -----> UserDefault.standart.value(forKey: "your key") //CHECKPOINT 13
 
 
    LIFECYCLE
    [DESCRIPTION]
    you have already known it from Flutter. for show how to use it,we gonna add the description features.
 
 
    [USAGE]
    - we gonna create the description label as much as brands count in a list.(CP14)
    - but we shoudl clear the cache data to make sure that userDefault has no any data.(CP15)
    - we gotta touch the some code lines so previous code flow doesn't crash.CP16 more than one exist look at all CP16!
    - well,if we have created description repo,we can start the lifeCycles. But before the start,I wanna explain the what we gonna do.
    
    we have already list of brands. when we click the any brands we will go to description screen. After that, we can chagne the description
    text. In additon,when we go back the lsit screen, description will save and go againt he description screen, new version will. Also,
    if we remove the all descriptin from keyboard, that brand will delete. I mean, user wouln't wants to it. let's start.
    
    - create dummy description CP17
    - reach the masterView(HomeViewController) from detailScreen(DetailViewController).CP18

    - we gotta assing our HomeViewController to masterView on the DetailViewController. For doing that, go to prepare function. CP19
 
    - go the DescriptionViewController, and create the our first lifeCycle function. it is "viewWillDissapper". it runs when you leave the
    current screen to other screens, I mean it runs when your screen will dissapperd. CP20
 
    - create our second lifeCycle function that "viewWillAppear". it runs when the current screen appear every time on your simulator or real
    device. Be careful that difference between viewDidLoad and this. viewDidLoad runs only once when app init first time. but viewWillAppear
    always working when related screen appeared. CP21
 
    - from here on , we gonna set up the some back from Detail screen situation. But we gonna need to selected row index. For that, we have created
    the selectedRowIndex CP22 and being operational CP23
 
    - let's go deeply to lifeCycle and add the keyboard situation. when we go to detail screen, keybaord will open automatically. and same way,
    it will close when you leave the detail screen. CP 24 on the DetailScreen.
 
 */

import UIKit

class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {//CHECKPOINT 1

    @IBOutlet weak var myTableView: UITableView!
    var dummyDescription:String = ""  //CP17
    
    var selectedRowIndex:Int = -1  // CP22
   
    
    override func viewWillAppear(_ animated: Bool) {   // CP21
        super.viewWillAppear(animated)
        
        if selectedRowIndex == -1 {        //that situation means that if any row is not selected, do nothing,
            return
        }
        
        if dummyDescription == "" {                                                 // in here, we have done that mentioned before.
            Repo.shared.description.remove(at: selectedRowIndex)                    // we have said that when user removes the all desription,
            Repo.shared.brands.remove(at: selectedRowIndex)                        // that brand will delete.
        }else if dummyDescription == Repo.shared.description[selectedRowIndex]{  //if there is no changing, do nothing.
            return
        }else{
            Repo.shared.description[selectedRowIndex] = dummyDescription  // if there is a changing, update your description according to your index.
        }
        saveData()                 //save your all change permantly.
        myTableView.reloadData()  // reload your tableView.
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        assingDelegated()  // CHECKPOINT 1
        setUpTitle()
        loadPreviousData()
        UserDefaults.standard.removeObject(forKey: Repo.shared.userDefaultKEY) // CP15
//        let editButton = editButtonItem                                //CHECKPOINT 9
//        editButton.tintColor = .white                                 // creating editButton and set up color. There are 2 type of how to add View.
//        self.navigationItem.leftBarButtonItem = editButton           // First way is that and it uses for if there is only barButton.
//        self.navigationItem.leftBarButtonItems?.append(editButton)  //  Second way is if there are one more than barButton,add button like this.
    }
    
    func setUpTitle(){          //CHECKPOINT 5
        self.title = "All Brands"
    }
    
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        myTableView.isEditing = !myTableView.isEditing
    }
    @IBAction func barButtonAction(_ sender: UIBarButtonItem) {
        getAlert()
    }
    
    fileprivate func assingDelegated() {
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {   //CHECKPOINT 3
        return Repo.shared.brands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {  //CHECKPOINT 4
        let cell:UITableViewCell = myTableView.dequeueReusableCell(withIdentifier: "brandCell")!  // we have created TableViewCell object to use it on our table.
        cell.textLabel?.text = Repo.shared.brands[indexPath.row]      // that cell has default label,
        return cell
    }
    
    func addBrand(brand:String){                   //CHECKPOINT6
        Repo.shared.brands.insert(brand, at: 0)        // added the new brand to list.
        Repo.shared.description.insert("None", at: 0) //CP16 when new brand added,description will be none. We will be able to change in progress.
        let indexPath:IndexPath = IndexPath(row: 0, section: 0)    //created indexpath for tableView.
        myTableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.left) // added the tableView.
        saveData()
    }
    
    @objc func getAlert(){
        
        if myTableView.isEditing == true{    //CHECKPOINT 10. In here, we have checked the if isEditing mode is open, returned and function has overed.
            return
        }
        
        let alertCtrl:UIAlertController = UIAlertController(title: "ADD BRAND", message: "Please enter the what you want brand...", preferredStyle: UIAlertController.Style.alert)  //created alert Controller
        alertCtrl.addTextField(configurationHandler: {   // added the textFiedl from  alertController object. IOS already gives us.
            textFieldBrand in
            textFieldBrand.placeholder = "Enter your brand..."    // also we can reach all feature.
        })
        let okeyButton:UIAlertAction = UIAlertAction(title: "Okey", style: UIAlertAction.Style.default,handler: {
            button in
            let brandTextField = alertCtrl.textFields![0] as UITextField   // reach the textFiedl from alert object. But it gives us array oftextField.
            self.addBrand(brand: brandTextField.text!)
        })
        let cancelButton:UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default,handler: nil) //handler is nil for cancel
        alertCtrl.addAction(okeyButton)
        alertCtrl.addAction(cancelButton)
        present(alertCtrl, animated: true,completion: nil)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {    //CHECKPOINT 7
        super.setEditing(editing, animated:animated)
        myTableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView:UITableView,commit editingStyle:UITableViewCell.EditingStyle,forRowAt indexPath:IndexPath){  //CHECKPOINT8
        if editingStyle == .delete{
            Repo.shared.brands.remove(at: indexPath.row)
            Repo.shared.description.remove(at: indexPath.row)
            myTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
        }
    }
    
    func saveData(){      //CHECKPOINT 12 we have used it on the addBrand fucntion.
        UserDefaults.standard.set(Repo.shared.brands,forKey: Repo.shared.userDefaultKEY)
        UserDefaults.standard.set(Repo.shared.description, forKey: Repo.shared.userDefaultKeyDes) //CP16 saved descriptions.
    }
    func loadPreviousData(){        //CHECKPOINT 13 also we have used on the viewDidLoad.
        if let previousData = UserDefaults.standard.value(forKey: Repo.shared.userDefaultKEY) as? [String] {
            Repo.shared.brands = previousData
        }
        
        //CP16 we have done same things as brands.
        if let previousDataDes = UserDefaults.standard.value(forKey: Repo.shared.userDefaultKeyDes) as? [String] {
            Repo.shared.description = previousDataDes
        }
        myTableView.reloadData()

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {    //CHECKPOINT 14
        performSegue(withIdentifier: "detailPage", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc:DetailViewController =  segue.destination as? DetailViewController{
            selectedRowIndex = myTableView.indexPathForSelectedRow!.row               //CP 23
            vc.fillDesCription(value: Repo.shared.description[selectedRowIndex])     //CP 23
            vc.masterView = self //CP19
        }
    }
}


class Repo{
    private init(){}
    static var shared:Repo = Repo()
    var selectedRow:Int = 0
    var userDefaultKEY = "brand key"
    var userDefaultKeyDes = "des key"
    var brands:[String] = ["Lamborghini","Maserati","Ferrari","Fiat"]  //CHECKPOINT2
    var description:[String] = ["Aventedor","Gran Turismo","488GTB","500"]  // CP14
}

