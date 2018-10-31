import UIKit

class Bar:UIView {
    init(_ title:String, buttons:[Button]) {
        super.init(frame:.zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.textColor = .white
        label.font = .systemFont(ofSize:18, weight:.bold)
        label.text = title
        addSubview(label)
        
        label.leftAnchor.constraint(equalTo:leftAnchor, constant:20).isActive = true
        label.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
        
        var anchor:NSLayoutXAxisAnchor?
        buttons.forEach { button in
            addSubview(button)
            button.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
            if let right = anchor {
                button.rightAnchor.constraint(equalTo:right).isActive = true
            } else  {
                button.rightAnchor.constraint(equalTo:rightAnchor, constant:-10).isActive = true
            }
            anchor = button.leftAnchor
        }
    }
    
    required init?(coder:NSCoder) { return nil }
    override var intrinsicContentSize:CGSize { return CGSize(width:UIView.noIntrinsicMetric, height:60) }
}
