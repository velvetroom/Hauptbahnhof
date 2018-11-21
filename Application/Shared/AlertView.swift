import UIKit

class AlertView:UIViewController {
    var onAccept:(() -> Void)?
    var onCancel:(() -> Void)?
    var message = String()
    var accept:String?
    var cancel:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.alpha = 0
        makeOutlets()
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration:0.7) { [weak self] in
            self?.view.alpha = 1
        }
    }
    
    private func makeOutlets() {
        let icon = UIImageView(image:#imageLiteral(resourceName: "alert.pdf"))
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.clipsToBounds = true
        icon.contentMode = .center
        icon.isUserInteractionEnabled = false
        view.addSubview(icon)
        
        let message = UILabel()
        message.translatesAutoresizingMaskIntoConstraints = false
        message.isUserInteractionEnabled = false
        message.textAlignment = .center
        message.textColor = .white
        message.numberOfLines = 0
        message.font = .systemFont(ofSize:18, weight:.light)
        message.text = self.message
        view.addSubview(message)
        
        if let accept = self.accept {
            let button = ButtonTextView(accept, color:.spreeBlue)
            button.addTarget(self, action:#selector(selectAccept), for:.touchUpInside)
            view.addSubview(button)
            button.rightAnchor.constraint(equalTo:view.rightAnchor, constant:-20).isActive = true
            
            if #available(iOS 11.0, *) {
                button.bottomAnchor.constraint(
                    equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant:-20).isActive = true
            } else {
                button.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant:-20).isActive = true
            }
        }
        
        if let cancel = self.cancel {
            let button = ButtonTextView(cancel, color:.sunriseRed)
            button.addTarget(self, action:#selector(selectCancel), for:.touchUpInside)
            view.addSubview(button)
            button.leftAnchor.constraint(equalTo:view.leftAnchor, constant:20).isActive = true
            
            if #available(iOS 11.0, *) {
                button.bottomAnchor.constraint(
                    equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant:-20).isActive = true
            } else {
                button.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant:-20).isActive = true
            }
        }
        
        icon.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        icon.topAnchor.constraint(equalTo:view.topAnchor, constant:50).isActive = true
        
        message.topAnchor.constraint(equalTo:icon.bottomAnchor, constant:30).isActive = true
        message.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        message.widthAnchor.constraint(lessThanOrEqualToConstant:300).isActive = true
    }
    
    private func fadeOut(completion:(() -> Void)?) {
        view.isUserInteractionEnabled = false
        UIView.animate(withDuration:0.3, animations: { [weak self] in
            self?.view.alpha = 0
        }) { _ in
            Application.navigation.popViewController(animated:false)
            completion?()
        }
    }
    
    @objc private func selectAccept() { fadeOut(completion:onAccept) }
    @objc private func selectCancel() { fadeOut(completion:onCancel) }
}
