import UIKit

class HomeView:UIViewController {
    private weak var new:ButtonTextView!
    private weak var resume:ButtonTextView!
    private weak var newBottom:NSLayoutConstraint!
    private let presenter = HomePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.alpha = 0
        makeOutlets()
        presenter.viewModel = { [weak self] viewModel in
            self?.new.isEnabled = viewModel.newEnabled
            self?.resume.isEnabled = viewModel.resumeEnabled
            self?.new.alpha = viewModel.newAlpha
            self?.resume.alpha = viewModel.resumeAlpha
        }
        presenter.fadeOut = { [weak self] completion in
            self?.newBottom.constant = 40
            UIView.animate(withDuration:1, animations: { [weak self] in
                self?.view.alpha = 0
                self?.view.layoutIfNeeded()
            }) { _ in completion() }
        }
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration:2, animations: { [weak self] in
            self?.view.alpha = 1
        }) { [weak self] _ in
            self?.newBottom.constant = -100
            UIView.animate(withDuration:1) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    private func makeOutlets() {
        let sky = HomeSkyView()
        view.addSubview(sky)
        
        let new = ButtonTextView(.local("HomeView.new"), color:.spreeBlue)
        new.addTarget(presenter, action:#selector(presenter.new), for:.touchUpInside)
        view.addSubview(new)
        self.new = new
        
        let resume = ButtonTextView(.local("HomeView.resume"), color:.spreeBlue)
        resume.addTarget(presenter, action:#selector(presenter.resume), for:.touchUpInside)
        view.addSubview(resume)
        self.resume = resume
        
        sky.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        sky.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        sky.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        sky.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        
        new.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        newBottom = new.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant:40)
        newBottom.isActive = true
        
        resume.centerXAnchor.constraint(equalTo:new.centerXAnchor).isActive = true
        resume.topAnchor.constraint(equalTo:new.bottomAnchor, constant:20).isActive = true
    }
}
