import UIKit

class ProfileView:UIViewController {
    private let presenter = ProfilePresenter()
    
    init() {
        super.init(nibName:nil, bundle:nil)
        self.modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder:NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.alpha = 0
        makeOutlets()
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration:1) { [weak self] in
            self?.view.alpha = 1
        }
    }
    
    private func makeOutlets() {
        let icon = UIImageView(image:#imageLiteral(resourceName: "user.pdf"))
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.isUserInteractionEnabled = false
        icon.clipsToBounds = true
        icon.contentMode = .center
        view.addSubview(icon)
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.isUserInteractionEnabled = false
        title.attributedText = presenter.title
        view.addSubview(title)
        
        let resume = ButtonTextView(.local("ProfileView.resume"), color:.spreeBlue)
        resume.addTarget(self, action:#selector(self.resume), for:.touchUpInside)
        view.addSubview(resume)
        
        icon.leftAnchor.constraint(equalTo:view.leftAnchor, constant:20).isActive = true
        
        resume.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        
        title.centerYAnchor.constraint(equalTo:icon.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo:icon.rightAnchor, constant:5).isActive = true
        
        if #available(iOS 11.0, *) {
            icon.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant:20).isActive = true
            resume.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant:-20).isActive = true
        } else {
            icon.topAnchor.constraint(equalTo:view.topAnchor, constant:20).isActive = true
            resume.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant:-20).isActive = true
        }
    }
    
    @objc private func resume() {
        view.isUserInteractionEnabled = false
        UIView.animate(withDuration:0.5, animations: { [weak self] in
            self?.view.alpha = 0
        }) { _ in
            Application.navigation.dismiss(animated:false)
        }
    }
}
