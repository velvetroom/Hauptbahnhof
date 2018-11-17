import UIKit
import Hauptbahnhof

class ProfilePresenter {
    let title:NSAttributedString
    let knowledge:CGFloat
    let courage:CGFloat
    let empathy:CGFloat
    let diligence:CGFloat
    private let master = Factory.makeMaster()
    
    init() {
        let string = NSMutableAttributedString()
        string.append(NSAttributedString(string:master.player.persona.rawValue, attributes:
            [.foregroundColor:UIColor.spreeBlue,.font:UIFont.systemFont(ofSize:24, weight:.medium)]))
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.positivePrefix = "\n"
        string.append(NSAttributedString(string:formatter.string(from:NSNumber(value:master.player.score))!, attributes:
            [.foregroundColor:UIColor.white,.font:UIFont.systemFont(ofSize:12, weight:.light)]))
        title = string
        knowledge = CGFloat(master.player.knowledge) / 100
        courage = CGFloat(master.player.courage) / 100
        empathy = CGFloat(master.player.empathty) / 100
        diligence = CGFloat(master.player.diligence) / 100
    }
}
