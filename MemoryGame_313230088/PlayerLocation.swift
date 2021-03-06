
import Foundation

class PlayerLocation : Codable{
    var lat: Double
    var lon: Double
    
    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon    }
    
    func getLat()->Double{
        return self.lat
    }
    
    func getLon()->Double{
        return self.lon
    }
}
