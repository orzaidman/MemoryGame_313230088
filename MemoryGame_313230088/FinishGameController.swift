//
//  FinishGameController.swift
//  MemoryGame
//
//  Created by bobo on 18/05/2021.
//  Copyright © 2021 Tal. All rights reserved.
//

import UIKit

class FinishGameController: UIViewController{
    
    @IBOutlet weak var Main_Game_LBL_timer_finish: UILabel!
    @IBOutlet weak var Main_Game_LBL_moves_finish: UILabel!
    @IBOutlet weak var Main_Game_LBL_startAgain_finish: UIButton!

    let  viewController = ViewController()
    
    override func viewDidLoad() {

        let timer =  UserDefaults.standard.integer(forKey: "timer")
        let moves =  UserDefaults.standard.integer(forKey: "moves")

        Main_Game_LBL_timer_finish.text = "Timer: " + String(timer)
       Main_Game_LBL_moves_finish.text = "Moves: " + String(moves)
        

    }
    
}
