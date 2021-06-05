import UIKit

class mainController: UIViewController {
    var name: String = ""

    @IBOutlet weak var startGame_LBL_name: UITextField!
    
    @IBAction func StartGame(_ sender: Any){
        UserDefaults.standard.set(startGame_LBL_name.text, forKey: "name")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GameController") as! GameController
        self.present(nextViewController, animated:true, completion:nil)

  
    }
    
}
