
import Foundation

class DataManager{
    
    static func fromJson(scoresListJson: String) ->[score]{
        let data = Data(scoresListJson.utf8)
        do {
            return try JSONDecoder().decode([score].self, from: data)
        } catch {
        }
        return [score]()
    }
    
    static func toJson(scoresList : [score]) -> String{
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(scoresList)
        let scoresListJson: String = String(data: data, encoding: .utf8)!
        
        return scoresListJson
    }
    
    
    static func getData() -> [score]{
        
        let scoresListJson = UserDefaults.standard.string(forKey: "scores")
        if let safeHighScoresJson = scoresListJson {
            return self.fromJson(scoresListJson: safeHighScoresJson)
        }
        
        return [score]()
    }
    
    static func saveData(scoresList : [score]) {
    
        let highScoresJson: String = self.toJson(scoresList: scoresList)
        UserDefaults.standard.set(highScoresJson, forKey: "scores")
    }
    
}
