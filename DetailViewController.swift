//
//  DetailViewController.swift
//  SimleBrandListApp
//
//  Created by Semih Ekmen on 2.03.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UITextView!
    var descriptionOption:String = ""
    var masterView: HomeViewController?   //CP18

    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text =  descriptionOption
    }
    
    func fillDesCription(value:String){
        descriptionOption = value
        if isViewLoaded {
            descriptionLabel.text = descriptionOption
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {   //CP20
        descriptionLabel.resignFirstResponder()          // CP24
        masterView?.dummyDescription = descriptionLabel.text   // we have assigned the current text value which appear on the screen to dummyText.
    }                                                         
    
    override func viewWillAppear(_ animated: Bool) {
        descriptionLabel.becomeFirstResponder()         // CP 24
    }
    
}
