import UIKit

class HomeSkyView:UIView {
    init() {
        super.init(frame:.zero)
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        let skyline = UIImageView(image:#imageLiteral(resourceName: "skyline.pdf"))
        skyline.translatesAutoresizingMaskIntoConstraints = false
        skyline.clipsToBounds = true
        skyline.contentMode = .center
        skyline.isUserInteractionEnabled = false
        skyline.alpha = 0.2
        addSubview(skyline)
        
        let rect = CGRect(x:0, y:-3000, width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height + 3000)
        let animation = CABasicAnimation(keyPath:"transform.translation.y")
        animation.duration = 100
        animation.fromValue = 0
        animation.toValue = 3000
        animation.autoreverses = true
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        
        let layerA = CAGradientLayer()
        layerA.startPoint = CGPoint(x:0.5, y:0)
        layerA.endPoint = CGPoint(x:0.5, y:1)
        layerA.locations = [0, 1]
        layerA.opacity = 0.2
        layerA.colors = [UIColor(white:1, alpha:0.3).cgColor, UIColor.black.cgColor]
        layerA.frame = UIScreen.main.bounds
        layer.insertSublayer(layerA, below:skyline.layer)
        
        let layerB = CAGradientLayer()
        layerB.startPoint = CGPoint(x:0.5, y:0)
        layerB.endPoint = CGPoint(x:0.5, y:1)
        layerB.locations = [0, 1]
        layerB.opacity = 0.3
        layerB.colors = [UIColor(white:1, alpha:0.3).cgColor, UIColor.black.cgColor]
        layerB.frame = rect
        layerB.add(animation, forKey:"animation")
        layer.insertSublayer(layerB, above:skyline.layer)
        
        skyline.topAnchor.constraint(equalTo:topAnchor).isActive = true
        skyline.centerXAnchor.constraint(equalTo:centerXAnchor, constant:50).isActive = true
    }
    
    required init?(coder:NSCoder) { return nil }
}
