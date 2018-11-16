import UIKit
import Hauptbahnhof

class ProfilePresenter {
    let title:NSAttributedString
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
    }
}
