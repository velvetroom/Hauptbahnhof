import UIKit

class ButtonTextView:UIButton {
    init(_ title:String, color:UIColor) {
        super.init(frame:.zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = 6
        backgroundColor = color
        setTitleColor(.black, for:.normal)
        setTitleColor(UIColor(white:0, alpha:0.2), for:.highlighted)
        setTitle(title, for:[])
        titleLabel!.font = .systemFont(ofSize:14, weight:.bold)
    }
    
    required init?(coder:NSCoder) { return nil }
    override var intrinsicContentSize:CGSize { return CGSize(width:140, height:34) }
}
