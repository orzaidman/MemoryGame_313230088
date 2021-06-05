//
//  GameController.swift
//  MemoryGame_313230088
//
//  Created by bobo on 05/06/2021.
//

import Foundation
import UIKit
import CoreLocation

class GameController: UIViewController {

    @IBOutlet weak var game_BTN_card1: UIButton!
    @IBOutlet weak var game_BTN_card2: UIButton!
    @IBOutlet weak var game_BTN_card3: UIButton!
    @IBOutlet weak var game_BTN_card4: UIButton!
    @IBOutlet weak var game_BTN_card5: UIButton!
    @IBOutlet weak var game_BTN_card6: UIButton!
    @IBOutlet weak var game_BTN_card7: UIButton!
    @IBOutlet weak var game_BTN_card8: UIButton!
    @IBOutlet weak var game_BTN_card9: UIButton!
    @IBOutlet weak var game_BTN_card10: UIButton!
    @IBOutlet weak var game_BTN_card11: UIButton!
    @IBOutlet weak var game_BTN_card12: UIButton!
    @IBOutlet weak var game_BTN_card13: UIButton!
    @IBOutlet weak var game_BTN_card14: UIButton!
    @IBOutlet weak var game_BTN_card15: UIButton!
    @IBOutlet weak var game_BTN_card16: UIButton!
    @IBOutlet weak var game_BTN_moves: UILabel!
    @IBOutlet weak var game_BTN_timer: UILabel!

        let game = MemoryGame()
        var cards = [Card]()
        var buttons = [UIButton]()
        var moves: Int = 0
        var playerName: String = ""
        var ifFinish: Bool = false
        var time = 0
        var timer = Timer()
        var hideImage = UIImage()
        var scores = [score]()
        var myLocation : PlayerLocation!
        var locationManager: CLLocationManager!


        override func viewDidLoad() {
            super.viewDidLoad()
            hideImage = #imageLiteral(resourceName: "back")
            buttons = [game_BTN_card1,game_BTN_card2,game_BTN_card3,game_BTN_card4,game_BTN_card5,game_BTN_card6,game_BTN_card7,game_BTN_card8,
                        game_BTN_card9,game_BTN_card10,game_BTN_card11,game_BTN_card12,game_BTN_card13,game_BTN_card14,game_BTN_card15,game_BTN_card16]
      
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()


            self.initGame()
        }
        

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if game.isPlaying {
            resetGame()
        }
    }

    func startTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    func storeData(){
        self.scores = DataManager.getDataFromtorage()
        let nameTemp = UserDefaults.standard.string(forKey: "name")

        let score : score = score( time : self.time, loc: self.myLocation, name : nameTemp!)
        insertScore(myScore : score)
        DataManager.saveScoresListInStorage(scoresList: self.scores)
    }

    func insertScore(myScore : score){
        
        if(scores.isEmpty){
            scores.append(myScore)
            return
        }
                
        if(!insertToListByTime(myScore: myScore) && scores.count < 10){
            self.scores.insert(myScore, at: scores.count)
        }
        
        if(scores.count > 10){
            scores.remove(at: scores.count - 1)
        }
        
    }

    func insertToListByTime(myScore : score) -> Bool{
        for i in  0 ..< scores.count {
            if(myScore.time < scores[i].time){
                scores.insert(myScore, at: i)
                return true
            }
        }
        
        return false
    }
    @objc func updateTimer(){
        time += 1
        game_BTN_timer.text = "Timer: "+String(time)
    }


    @IBAction func onBackPressed(_ sender: UIButton) {
        if let nav = self.navigationController {
                   nav.popViewController(animated: true)
               }
    }


    @IBAction func cardClicked(_ sender: UIButton) {
        self.moves+=1
        game_BTN_moves.text = String(moves)
        sender.imageView?.layer.transform = CATransform3DIdentity
        ifFinish = game.cardSelected(findCardByTag(button :sender))
        if (ifFinish){
            finishGame()
        }
    }

    func finishGame(){
        timer.invalidate()
        storeData()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "maxScoreController") as! maxScoreController
        self.present(nextViewController, animated:true, completion:nil)

    }

 


    func findCardByTag(button: UIButton)->Card?{
        for card in cards {
            if (card.tag == button.tag){
               return card
            }
        }
        return nil
    }

    func initGame() {
        self.startTimer()
        buttons.shuffle()
        time = 0
        moves = 0
        game_BTN_moves.text = String(moves)
        cards = game.newGame(buttonsArray: self.buttons)
        hideCards()
    }

    func resetGame() {
        timer.invalidate()
        game.restartGame()
        initGame()
    }


    func hideCards() {
        for button in self.buttons{
            button.imageView?.layer.transform = CATransform3DMakeScale(0.0, 0.0, 0.0)
        }
    }

    }


    extension GameController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            myLocation = PlayerLocation(lat: lat, lon: lon)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        myLocation = PlayerLocation(lat: 0, lon: 0)
    }
}

