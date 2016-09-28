//
//  SettingsViewController.swift
//  FoodTracker
//
//  Created by Kevin Harris on 9/27/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: UIButton) {
        
        spinner.startAnimating()
        
        BackendlessManager.sharedInstance.logoutUser(
            completion: {
            
                self.spinner.stopAnimating()
                
                self.performSegue(withIdentifier: "gotoLoginFromMealTable", sender: sender)
            },
            
            error: { message in
                
                self.spinner.stopAnimating()
                
                Utility.showAlert(viewController: self, title: "Logout Error", message: message)
            })
    }
}
