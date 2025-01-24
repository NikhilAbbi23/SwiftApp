//
//  SignUpViewController.swift
//  FirstApp
//
//  Created by Nikhil on 22/01/25.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
              let phone = phoneTextField.text, !phone.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
            else {
            showAlert(title: "Error", message: "Please fill all the fields")
            return
        }
        
        if !isValidEmail(email) {
            showAlert(title: "Error", message: "Invalid email format")
            return
        }
        if !isValidPhone(phone) {
            showAlert(title: "Error", message: "Invalid phone number format")
            
        }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newUser = User(context: context)
        newUser.username = username
        newUser.email = email
        newUser.phone = Int64(phone) ?? 0000000000
        newUser.password = password
        
        do {
            try context.save( )
            showAlert(title: "Success", message: "Sign Up successfull"){ _ in
                self.navigateToSignIn()
            }
        } catch {
            showAlert(title: "Error", message: "Sign Up failed. Please try again.")
        }
        
    }
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return email.range(of: emailRegex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    private func isValidPhone(_ phone: String) -> Bool {
        let phoneRegex = "^[0-9]{10}$"
        return phone.range(of: phoneRegex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    private func showAlert(title: String,message: String, completion: ((UIAlertAction) -> Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
        present(alert, animated: true, completion: nil)
    }
    
    private func navigateToSignIn() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
                if let signInVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                    if let navigationController = self.navigationController {
                        navigationController.pushViewController(signInVC, animated: true)
                    } else {
                        self.present(signInVC, animated: true, completion: nil)
                    }
                }
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
