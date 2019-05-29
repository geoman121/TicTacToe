//
//  LoginViewController.swift
//  TicTacToe
//
//  Created by George James Manayath on 28/05/19.
//  Copyright © 2019 George James Manayath. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var ref = DatabaseReference.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
       
            goToPlayGame()
    }
    

    @IBAction func registerButton(_ sender: Any) {
        Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { (user, error) in
            if let error = error{
                print(("cannot login: \(error)"))
            }
            else{
                print("user UID ")
                self.ref.child("tictactoe").child("users").child(self.splitEmail(email: (user?.user.email)!)).child("Request").setValue(user?.user.uid)
                self.goToPlayGame()
            }
            
            
        }
        
    }
    
    func splitEmail(email:String) -> String{
        let emailArray = email.split(separator: "@")
        return String(emailArray[0])
    }
    
    func goToPlayGame(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "playGame", sender: nil)
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vcPlayGame = segue.destination as? ViewController{
             if let user = Auth.auth().currentUser{
            vcPlayGame.userUID = user.uid
            vcPlayGame.userEmail = user.email

        }
    }
}
}
