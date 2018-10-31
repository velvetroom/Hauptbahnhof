import UIKit

class ButtonText:UIButton {
    init(_ title:String) {
        super.init(frame:.zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = 6
        backgroundColor = .spreeBlue
        setTitleColor(.black, for:.normal)
        setTitleColor(UIColor(white:0, alpha:0.2), for:.highlighted)
        setTitle(title, for:[])
        titleLabel!.font = .systemFont(ofSize:15, weight:.bold)
    }
    
    required init?(coder:NSCoder) { return nil }
    override var intrinsicContentSize:CGSize { return CGSize(width:140, height:34) }
}
