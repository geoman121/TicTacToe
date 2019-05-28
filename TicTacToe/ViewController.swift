//
//  ViewController.swift
//  TicTacToe
//
//  Created by George James Manayath on 28/05/19.
//  Copyright © 2019 George James Manayath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let imageX = UIImage(named: "cross.png")
    let imageO = UIImage(named: "nought.png")
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func butonSelect(_ sender: Any) {
        
        let buSelect = sender as! UIButton
        playGame(buSelect: buSelect)
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
        
        let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {(UIAlertAction) in
            self.ActivePlayer = 1
            for i in 1..<10
            {
                if let button = self.view.viewWithTag(i) as? UIButton
                {
                    button.setImage(nil, for: [])
                    button.isEnabled = true
                }
            }
            self.player1 = [0,0,0,0,0,0,0,0,0]
            self.player2 = [0,0,0,0,0,0,0,0,0]
        })
        
        alert.addAction(restartAction)
        self.present(alert, animated: true, completion: nil)
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
        
        else if(count%9 == 0 && winner == -1){
            
            winnerAlert(msg: "The game is draw", title: "Draw")
            
        }
    }
}

