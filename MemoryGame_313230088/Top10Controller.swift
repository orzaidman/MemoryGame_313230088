//
//  Top10Controller.swift
//  MemoryGame
//
//  Created by bobo on 22/05/2021.
//  Copyright © 2021 Tal. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class Top10Controller:  UIViewController, UITableViewDelegate,UITableViewDataSource  {
    

    @IBOutlet weak var scores_LST_scores: UITableView!
    @IBOutlet weak var MyMap: MKMapView!
    var scoresList : [score]!
    var myCamera: MKMapCamera!
    let cellId = "score"

    override func viewDidLoad() {
        super.viewDidLoad()
        MyMap.showsUserLocation = true
        MyMap.layer.cornerRadius = 50.0
        scoresList = DataManager.getDataFromtorage()
        addLocationsToMap()
        setupTable()
    }
    
    func setupTable(){
        scores_LST_scores.delegate = self
        scores_LST_scores.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.scoresList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : Cell? = self.scores_LST_scores.dequeueReusableCell(withIdentifier: cellId) as? Cell
        
        cell?.cell_LBL_name?.text = String(scoresList[indexPath.row].name)
        
        if(cell == nil){
            cell = Cell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellId)
        }
        
        return cell!
    }
    
    @IBAction func onBackPressed(_ sender: UIButton) {
        if let nav = self.navigationController {
                   nav.popViewController(animated: true)
               } else {
                   self.dismiss(animated: true, completion: nil)
               }
    }
    
    
    func addLocationsToMap(){
            
        for highScore in scoresList{
            let point = MKPointAnnotation()
            let pointlatitude = Double(highScore.getLocation().getLat())
            let pointlongitude = Double(highScore.getLocation().getLon())
            point.title = highScore.name
            
            point.coordinate = CLLocationCoordinate2DMake(pointlatitude ,pointlongitude)
            MyMap.addAnnotation(point)
        }
        
    }
    
    func showLocationOnMap(index : Int){
        myCamera = MKMapCamera(lookingAtCenter: CLLocationCoordinate2D(latitude: scoresList[index].location.lat, longitude: scoresList[index].location.lon), fromDistance: 500.0, pitch: 90.0, heading: 180.0)
        self.MyMap.setCamera(myCamera, animated: true)
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showLocationOnMap(index: indexPath.row)
    }
    
}
