//
//  ViewController.swift
//  TicTacToe
//
//  Created by George James Manayath on 28/05/19.
//  Copyright © 2019 George James Manayath. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    

    @IBOutlet weak var bu1: UIButton!
    @IBOutlet weak var bu2: UIButton!
    @IBOutlet weak var bu3: UIButton!
    @IBOutlet weak var bu4: UIButton!
    @IBOutlet weak var bu5: UIButton!
    @IBOutlet weak var bu6: UIButton!
    @IBOutlet weak var bu7: UIButton!
    @IBOutlet weak var bu8: UIButton!
    @IBOutlet weak var bu9: UIButton!
    

    var userUID : String?
    var userEmail : String?
    @IBOutlet weak var txtPlayerEmail: UITextField!
    let imageX = UIImage(named: "cross.png")
    let imageO = UIImage(named: "nought.png")
    
     var ref = DatabaseReference.init()
    override func viewDidLoad() {
        super.viewDidLoad()
       self.ref = Database.database().reference()
        incommingRequest()
    }

    @IBAction func butonSelect(_ sender: Any) {
        
        let buSelect = sender as! UIButton
        self.ref.child("tictactoe").child("PlayingOnline").child(sessionID!).child("\(buSelect.tag)").setValue(userEmail!)
       // playGame(buSelect: buSelect)
    }
    var count=0
    var player1 = [Int]()
    var player2 = [Int]()
    var ActivePlayer = 1
    func playGame(buSelect: UIButton){
        if ActivePlayer == 1
        {
            buSelect.setImage(imageX, for: .normal)
            player1.append(buSelect.tag)
            ActivePlayer = 2
        }
        else{
            buSelect.setImage(imageO, for: .normal)
            player2.append(buSelect.tag)
            ActivePlayer = 1 
        }
        buSelect.isEnabled = false
        findWinner()
    }
    
    
    
    func winnerAlert(msg: String, title: String){
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        let restartAction = UIAlertAction(title: "Reset", style: .default, handler: {(UIAlertAction) in
            self.ActivePlayer = 1
            for i in 1..<10
            {
                if let button = self.view.viewWithTag(i) as? UIButton
                {
                    button.setImage(nil, for: [])
                  //  button.isEnabled = false
                }
            }
            self.player1 = [0,0,0,0,0,0,0,0,0]
            self.player2 = [0,0,0,0,0,0,0,0,0]
        })
        
        alert.addAction(restartAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func autoPlay(cellID: Int)
    {
        var buSelect : UIButton?
        switch cellID {
        case 1:
            buSelect = bu1
        case 2:
            buSelect = bu2
        case 3:
            buSelect = bu3
        case 4:
            buSelect = bu4
        case 5:
            buSelect = bu5
        case 6:
            buSelect = bu6
        case 7:
            buSelect = bu7
        case 8:
            buSelect = bu8
        case 9:
            buSelect = bu9
        default:
            buSelect = bu1
        }
        playGame(buSelect: buSelect!)
    }
    
    
    func findWinner(){
        var winner = -1
        count += 1
        //row 1
        if(player1.contains(1) && player1.contains(2) && player1.contains(3)){
            winner = 1
        }
        if(player2.contains(1) && player2.contains(2) && player2.contains(3)){
            winner = 2
        }
        
        //row 2
        if(player1.contains(4) && player1.contains(5) && player1.contains(6)){
            winner = 1
        }
        if(player2.contains(4) && player2.contains(5) && player2.contains(6)){
            winner = 2
        }
        
        //row 3
        if(player1.contains(7) && player1.contains(8) && player1.contains(9)){
            winner = 1
        }
        if(player2.contains(7) && player2.contains(8) && player2.contains(9)){
            winner = 2
        }
        
        //col1
        if(player1.contains(1) && player1.contains(4) && player1.contains(7)){
            winner = 1
        }
        if(player2.contains(1) && player2.contains(4) && player2.contains(7)){
            winner = 2
        }
        
        //col2
        if(player1.contains(2) && player1.contains(5) && player1.contains(8)){
            winner = 1
        }
        if(player2.contains(2) && player2.contains(5) && player2.contains(8)){
            winner = 2
        }
        
        //col3
        if(player1.contains(3) && player1.contains(6) && player1.contains(9)){
            winner = 1
        }
        if(player2.contains(3) && player2.contains(6) && player2.contains(9)){
            winner = 2
        }
        
        //dia1
        if(player1.contains(1) && player1.contains(5) && player1.contains(9)){
            winner = 1
        }
        if(player2.contains(1) && player2.contains(5) && player2.contains(9)){
            winner = 2
        }
        
        //dia2
        if(player1.contains(3) && player1.contains(5) && player1.contains(7)){
            winner = 1
        }
        if(player2.contains(3) && player2.contains(5) && player2.contains(7)){
            winner = 2
        }
        
        
        if winner != -1{
            var msg = ""
            if winner == 1{
                msg = "Player 1 is the winner"
            }
            else{
                msg = "Player 2 is the winner"
            }
            print(msg)
            winnerAlert(msg: msg, title: "Winner")
         
        }
        
//        else if(count%9 == 0 && winner == -1){
//
//            winnerAlert(msg: "The game is draw", title: "Draw")
//
//        }
    }
    
    func splitEmail(email:String) -> String{
        let emailArray = email.split(separator: "@")
        return String(emailArray[0])
    }
    
    var  playerSymbol : String?
    @IBAction func requestButton(_ sender: Any) {
        
         self.ref.child("tictactoe").child("users").child(splitEmail(email: (txtPlayerEmail.text)!)).child("Request").childByAutoId().setValue(userEmail!)
        playerSymbol = "X"
        playOnline(sessionID: "\(splitEmail(email: (userEmail)!)) \(splitEmail(email: (txtPlayerEmail.text)!))")
    }
    
    @IBAction func acceptButton(_ sender: Any) {
    
        self.ref.child("tictactoe").child("users").child(splitEmail(email: txtPlayerEmail.text!)).child("Request").childByAutoId().setValue(userEmail!)
        playerSymbol = "O"
        playOnline(sessionID: "\(splitEmail(email: (txtPlayerEmail.text)!)) \(splitEmail(email: (userEmail)!))")
    }
    
    func incommingRequest(){
        self.ref.child("tictactoe").child("users").child(splitEmail(email: userEmail!)).child("Request").observe(.value) { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshot{
                    if let playerRequest = snap.value as? String{
                        self.txtPlayerEmail.text = playerRequest
                        
                        self.ref.child("tictactoe").child("users").child(self.splitEmail(email: self.userEmail!)).child("Request").setValue(self.userUID)
                    }
                }
            }
        }
    }
    var sessionID:String?
    func playOnline(sessionID : String)
    {
        self.sessionID = sessionID
        self.ref.child("tictactoe").child("PlayingOnline").child(sessionID).removeValue()
        self.ref.child("tictactoe").child("PlayingOnline").child(sessionID).observe(.value) { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                self.player1.removeAll()
                self.player2.removeAll()
                for snap in snapshot{
                    if let playerEmail = snap.value as? String{
                       let keyCellID = snap.key as? String
                        if playerEmail == self.userEmail{
                            self.ActivePlayer = self.playerSymbol! == "X" ? 1 : 2
                        }else{
                            self.ActivePlayer = self.playerSymbol! == "X" ? 2 : 1
                        }
                        self.autoPlay(cellID: Int(keyCellID!)!)
                    }
                }
            }
        }
    }
    
    

    
}

