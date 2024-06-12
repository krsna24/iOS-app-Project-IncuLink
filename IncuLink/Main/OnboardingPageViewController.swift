//
//  File.swift
//  IncuLink
//
//  Created by Nitin ‘s on 28/05/24.
//

import UIKit

class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    
    
    // Array of view controllers for each onboarding screen
    lazy var onboardingScreens: [UIViewController] = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return [
            storyboard.instantiateViewController(withIdentifier: "OnboardingScreen1"),
            storyboard.instantiateViewController(withIdentifier: "OnboardingScreen2"),
            storyboard.instantiateViewController(withIdentifier: "OnboardingScreen3"),
            storyboard.instantiateViewController(withIdentifier: "OnboardingScreen4")
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.dataSource = self
        self.delegate = self
        
        // Set the initial view controller to be displayed
        if let firstViewController = onboardingScreens.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = onboardingScreens.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        
        return onboardingScreens[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = onboardingScreens.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < onboardingScreens.count else {
            return nil
        }
        
        return onboardingScreens[nextIndex]
    }
}
