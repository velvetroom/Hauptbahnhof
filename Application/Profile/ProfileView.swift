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
        
        let chart = ProfileChartView()
        view.addSubview(chart)
        
        let knowledge = UILabel()
        knowledge.translatesAutoresizingMaskIntoConstraints = false
        knowledge.isUserInteractionEnabled = false
        knowledge.textAlignment = .center
        knowledge.font = .systemFont(ofSize:12, weight:.ultraLight)
        knowledge.textColor = .white
        knowledge.text = .local("ProfileView.knowledge")
        view.addSubview(knowledge)
        
        let courage = UILabel()
        courage.translatesAutoresizingMaskIntoConstraints = false
        courage.isUserInteractionEnabled = false
        courage.textAlignment = .center
        courage.font = .systemFont(ofSize:12, weight:.ultraLight)
        courage.textColor = .white
        courage.text = .local("ProfileView.courage")
        view.addSubview(courage)
        
        let empathy = UILabel()
        empathy.translatesAutoresizingMaskIntoConstraints = false
        empathy.isUserInteractionEnabled = false
        empathy.font = .systemFont(ofSize:12, weight:.ultraLight)
        empathy.textColor = .white
        empathy.text = .local("ProfileView.empathy")
        view.addSubview(empathy)
        
        let diligence = UILabel()
        diligence.translatesAutoresizingMaskIntoConstraints = false
        diligence.isUserInteractionEnabled = false
        diligence.font = .systemFont(ofSize:12, weight:.ultraLight)
        diligence.textColor = .white
        diligence.textAlignment = .right
        diligence.text = .local("ProfileView.diligence")
        view.addSubview(diligence)
        
        let resume = ButtonTextView(.local("ProfileView.resume"), color:.spreeBlue)
        resume.addTarget(self, action:#selector(self.resume), for:.touchUpInside)
        view.addSubview(resume)
        
        icon.leftAnchor.constraint(equalTo:view.leftAnchor, constant:20).isActive = true
        
        title.centerYAnchor.constraint(equalTo:icon.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo:icon.rightAnchor, constant:5).isActive = true
        
        chart.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        chart.centerYAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
        chart.widthAnchor.constraint(equalToConstant:200).isActive = true
        chart.heightAnchor.constraint(equalToConstant:200).isActive = true
        
        knowledge.bottomAnchor.constraint(equalTo:chart.topAnchor, constant:-6).isActive = true
        knowledge.centerXAnchor.constraint(equalTo:chart.centerXAnchor).isActive = true
        
        courage.topAnchor.constraint(equalTo:chart.bottomAnchor, constant:6).isActive = true
        courage.centerXAnchor.constraint(equalTo:chart.centerXAnchor).isActive = true
        
        empathy.leftAnchor.constraint(equalTo:chart.rightAnchor, constant:6).isActive = true
        empathy.centerYAnchor.constraint(equalTo:chart.centerYAnchor).isActive = true
        
        diligence.rightAnchor.constraint(equalTo:chart.leftAnchor, constant:-6).isActive = true
        diligence.centerYAnchor.constraint(equalTo:chart.centerYAnchor).isActive = true
        
        resume.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        
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
