import UIKit

class GameCaretView:UIView {
    weak var left:NSLayoutConstraint! { didSet { left.isActive = true } }
    weak var top:NSLayoutConstraint! { didSet { top.isActive = true } }
    weak var height:NSLayoutConstraint! { didSet { height.isActive = true } }
    override var intrinsicContentSize:CGSize { return CGSize(width:8, height:UIView.noIntrinsicMetric) }
    
    init() {
        super.init(frame:.zero)
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        backgroundColor = .spreeBlue
        animate()
    }
    
    required init?(coder:NSCoder) { return nil }
    
    func update(rect:CGRect) {
        top.constant = rect.minY
        left.constant = rect.minX + 5
        height.constant = rect.height
    }
    
    private func animate() {
        DispatchQueue.main.asyncAfter(deadline:.now() + 4) {
            UIView.animate(withDuration:0.7, animations: { [weak self] in
                self?.alpha = 0
            }) { [weak self] _ in
                self?.alpha = 1
                self?.animate()
            }
        }
    }
}
