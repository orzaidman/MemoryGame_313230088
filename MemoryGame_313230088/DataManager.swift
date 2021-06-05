
import Foundation

class DataManager{
    static let SCORE_LIST_KEY = "SCORE_LIST_KEY"
    
    static func fromJsonToScoresList(scoresListJson: String) ->[score]{
        let decoder = JSONDecoder()
        let data = Data(scoresListJson.utf8)
        do {
            return try decoder.decode([score].self, from: data)
            
        } catch {
            print("somthing went wrong in fromJsonToScoresList")
        }
        return [score]()
    }
    
    static func fromScoresListToJson(scoresList : [score]) -> String{
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(scoresList)
        let scoresListJson: String = String(data: data, encoding: .utf8)!
        
        return scoresListJson
    }
    
    
    static func getDataFromtorage() -> [score]{
        
        let scoresListJson = UserDefaults.standard.string(forKey: SCORE_LIST_KEY)
        
        if let safeHighScoresJson = scoresListJson {
            return self.fromJsonToScoresList(scoresListJson: safeHighScoresJson)
        }
        
        return [score]()
    }
    
    static func saveScoresListInStorage(scoresList : [score]) {
    
        let highScoresJson: String = self.fromScoresListToJson(scoresList: scoresList)
        UserDefaults.standard.set(highScoresJson, forKey: SCORE_LIST_KEY)
    }
    
}
