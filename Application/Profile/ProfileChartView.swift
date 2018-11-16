import UIKit

class ProfileChartView:UIView {
    var knowledge:CGFloat = 0
    var empathy:CGFloat = 0
    var courage:CGFloat = 0
    var diligence:CGFloat = 0
    private weak var chart:CAShapeLayer?
    private weak var circle:CAShapeLayer?
    private weak var cross:CAShapeLayer?
    
    init() {
        super.init(frame:.zero)
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
    }
    
    required init?(coder:NSCoder) { return nil }
    
    override func layoutSubviews() {
        let side = min(frame.width, frame.height) / 2
        circle(side)
        chart(side)
        cross(side)
        super.layoutSubviews()
    }
    
    private func chart(_ side:CGFloat) {
        self.chart?.removeFromSuperlayer()
        let origin = UIBezierPath()
        origin.move(to:CGPoint(x:bounds.midX, y:bounds.midY))
        origin.addLine(to:CGPoint(x:bounds.midX, y:bounds.midY))
        origin.close()
        
        let destiny = UIBezierPath()
        destiny.move(to:CGPoint(x:bounds.midX, y:bounds.midY - (side * knowledge)))
        destiny.addLine(to:CGPoint(x:bounds.midX + (side * empathy), y:bounds.midY))
        destiny.addLine(to:CGPoint(x:bounds.midX, y:bounds.midY + (side * courage)))
        destiny.addLine(to:CGPoint(x:bounds.midX - (side * diligence), y:bounds.midY))
        destiny.close()
        
        let animation = CABasicAnimation(keyPath:"path")
        animation.duration = 1
        animation.fromValue = origin.cgPath
        animation.toValue = destiny.cgPath
        
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.spreeBlue.cgColor
        layer.frame = bounds
        layer.add(animation, forKey:String())
        layer.path = destiny.cgPath
        self.chart = layer
        self.layer.addSublayer(layer)
    }
    
    private func circle(_ side:CGFloat) {
        self.circle?.removeFromSuperlayer()
        let path = UIBezierPath()
        path.addArc(withCenter:CGPoint(x:bounds.midX, y:bounds.midY), radius:side, startAngle:0.0001, endAngle:0, clockwise:true)
        path.move(to:CGPoint(x:bounds.midX - side, y:bounds.midY))
        path.addLine(to:CGPoint(x:bounds.midX + side, y:bounds.midY))
        path.move(to:CGPoint(x:bounds.midX, y:bounds.midY - side))
        path.addLine(to:CGPoint(x:bounds.midX, y:bounds.midY + side))
        path.close()

        let layer = CAShapeLayer()
        layer.lineDashPattern = [NSNumber(value:1), NSNumber(value:6)]
        layer.strokeColor = UIColor.spreeBlue.cgColor
        layer.path = path.cgPath
        layer.lineWidth = 1
        layer.lineCap = .round
        layer.lineJoin = .round
        layer.frame = bounds
        self.circle = layer
        self.layer.addSublayer(layer)
    }
    
    private func cross(_ side:CGFloat) {
        self.cross?.removeFromSuperlayer()
        let origin = UIBezierPath()
        origin.move(to:CGPoint(x:bounds.midX, y:bounds.midY))
        origin.addLine(to:CGPoint(x:bounds.midX, y:bounds.midY))
        origin.close()
        
        let destiny = UIBezierPath()
        destiny.move(to:CGPoint(x:bounds.midX - (side * diligence), y:bounds.midY))
        destiny.addLine(to:CGPoint(x:bounds.midX + (side * empathy ), y:bounds.midY))
        destiny.move(to:CGPoint(x:bounds.midX, y:bounds.midY - (side * knowledge)))
        destiny.addLine(to:CGPoint(x:bounds.midX, y:bounds.midY + (side * courage)))
        
        let animation = CABasicAnimation(keyPath:"path")
        animation.duration = 1
        animation.fromValue = origin.cgPath
        animation.toValue = destiny.cgPath
        
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.nightBlue.cgColor
        layer.lineWidth = 1
        layer.frame = bounds
        layer.add(animation, forKey:String())
        layer.path = destiny.cgPath
        self.cross = layer
        self.layer.addSublayer(layer)
    }
}
