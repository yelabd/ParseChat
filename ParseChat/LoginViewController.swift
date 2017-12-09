//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Youssef Elabd on 12/8/17.
//  Copyright © 2017 Youssef Elabd. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onSignUp(_ sender: Any) {
        
        if (usernameTextfield.text?.isEmpty)! || (passwordTextfield.text?.isEmpty)! {
            let alertController = UIAlertController(title: "Error", message: "username or password can't be empty", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default)
            
            alertController.addAction(OKAction)
            self.present(alertController, animated: true)
            
            
            return
        }
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameTextfield.text
        newUser.password = passwordTextfield.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default)
                
                alertController.addAction(OKAction)
                self.present(alertController, animated: true)
                
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
            }
        }
    }
    
    @IBAction func onLogin(_ sender: Any) {
        let username = usernameTextfield.text ?? ""
        let password = passwordTextfield.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
                
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default)
                
                alertController.addAction(OKAction)
                self.present(alertController, animated: true)
            } else {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
