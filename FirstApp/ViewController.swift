//
//  ViewController.swift
//  FirstApp
//
//  Created by Nikhil on 22/01/25.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!

    
    
    @IBAction func signInTapped(_ sender: UIButton) {
        guard let username = usernameTextfield.text, !username.isEmpty,
              let password = passwordTextfield.text, !password.isEmpty
        else {
            showAlert(title: "Error", message: "Please provide username and password")
            return
        }
        
        let contaxt = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        
        do {
            let users = try contaxt.fetch(fetchRequest)
            if users.count > 0 {
                UserDefaults.standard.set(username, forKey: "LoggedInUser")
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                showAlert(title: "Success", message: "Login successful"){
                    self.navigateToHelloWorld()}
            } else {
                showAlert(title: "Error", message: "Invalid username or password")
            }
        } catch {
            showAlert(title: "Error", message: "Something went wrong")
        }
        
    }
    
    private func navigateToHelloWorld() {
        
        guard let helloWorldVC = storyboard?.instantiateViewController(withIdentifier: "HelloWorldViewController") as? HelloWorldViewController else {
            print("Error: HelloWorldViewController not found")
            return
        }
        
        
        if let navigationController = navigationController {
            navigationController.pushViewController(helloWorldVC, animated: true)
        } else {
            print("Error: Navigation controller is not available")
        }
    }
    private func showAlert(title: String, message: String,completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?() }))
        present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let loggedInUsername = UserDefaults.standard.string(forKey: "loggedInUsername"), UserDefaults.standard.bool(forKey: "isLoggedIn") {
            navigateToHelloWorld()
        } else {
            //user is logged in. stay on sign in screen
        }
    }
    
}


