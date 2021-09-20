//
//  OnboardingViewController.swift
//  BrocoliSe
//
//  Created by Paulo Uchôa on 20/09/21.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    var didSendContinue: (()-> Void)?
    
    lazy var view0: UIView = {
        let view = Onboarding01()
        return view
    }()
    
    lazy var view1: UIView = {
        let view = Onboarding02()
        return view
    }()
    
    lazy var view2: UIView = {
        let view = Onboarding03()
        view.onboardingVC = self
        return view
    }()
    
    lazy var views = [view0, view1, view2]
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(views.count), height: view.frame.height)
        
        for count in 0..<views.count {
            scrollView.addSubview(views[count])
            views[count].frame = CGRect(x: view.frame.width * CGFloat(count), y: -80, width: view.frame.width, height: view.frame.height)
        }
        
        scrollView.delegate = self
        
        return scrollView
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = views.count
        pageControl.pageIndicatorTintColor = UIColor.greenMedium?.withAlphaComponent(0.4)
        pageControl.currentPageIndicatorTintColor = .greenMedium
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(pageControlTapHandler(sender:)), for: .touchUpInside)
        return pageControl
    }()
    
    @objc
    func pageControlTapHandler(sender: UIPageControl) {
        scrollView.scrollTo(horizontalPage: sender.currentPage, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.edgeTo(view: view)
        view.addSubview(pageControl)
        pageControl.pinTo(view)
        
    }
}

extension OnboardingViewController: Onboarding03Protocol {
    func buttonContinueAction() {
        print("foi")
        guard let didSend = self.didSendContinue else {return}
        didSend()
    }
    
    
}

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = -scrollView.contentInset.top
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

extension UIScrollView {
    func edgeTo(view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension UIScrollView {
    func scrollTo(horizontalPage: Int? = 0, verticalPage: Int? = nil, animated: Bool? = true) {
        var frame: CGRect = self.frame
        frame.origin.x = frame.size.width * CGFloat(horizontalPage ?? 0)
        self.scrollRectToVisible(frame, animated: animated ?? true)
    }
}

extension UIView {
    func pinTo(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
    }
}

