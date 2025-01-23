//
//  HelloWorldViewController.swift
//  FirstApp
//
//  Created by Nikhil on 23/01/25.
//

import UIKit

class HelloWorldViewController: UIViewController {

    @IBOutlet weak var logOutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
    }
    @objc func logOut() {
        UserDefaults.standard.removeObject(forKey: "loggedInUsername")
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        navigationController?.popToRootViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
