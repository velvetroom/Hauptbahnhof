import UIKit

class GameOptionView:UIControl {
    var viewModel:NSAttributedString? { didSet { label.attributedText = viewModel } }
    private weak var label:UILabel!
    
    init() {
        super.init(frame:.zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .nightBlue
        layer.cornerRadius = 6
        makeOutlets()
    }
    
    required init?(coder:NSCoder) { return nil }
    override var isSelected:Bool { didSet { update() } }
    override var isHighlighted:Bool { didSet { update() } }
    
    private func makeOutlets() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.textColor = .white
        addSubview(label)
        self.label = label
        
        label.topAnchor.constraint(equalTo:topAnchor, constant:20).isActive = true
        label.bottomAnchor.constraint(equalTo:bottomAnchor, constant:-20).isActive = true
        label.leftAnchor.constraint(equalTo:leftAnchor, constant:20).isActive = true
        label.rightAnchor.constraint(equalTo:rightAnchor, constant:-40).isActive = true
    }
    
    private func update() {
        if isSelected || isHighlighted {
            backgroundColor = .spreeBlue
            label.textColor = .black
        } else {
            backgroundColor = .nightBlue
            label.textColor = .white
        }
    }
}
