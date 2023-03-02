//
//  DetailViewController.swift
//  SimleBrandListApp
//
//  Created by Semih Ekmen on 2.03.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    var dummyDes:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = dummyDes
    }
    
    func settingUpTheDescription(des:String){
        dummyDes = des
        if isViewLoaded{
            descriptionLabel.text = dummyDes
        }
    }
    
}
