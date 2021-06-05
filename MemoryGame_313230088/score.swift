import UIKit
import Foundation
import CoreLocation

class score : Codable{
    var name: String = ""
    var time: Int = 0
    var location : PlayerLocation
    
    init(time: Int, loc: PlayerLocation, name: String) {
        self.time = time
        self.location = loc
        self.name = name
    }
    
    func getLocation()->PlayerLocation{
        return self.location
    }
    
}
