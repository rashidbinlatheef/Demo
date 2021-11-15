import Foundation
import UIKit

protocol Transition {
    
    func pushViewControler(_ viewController: UIViewController, animated: Bool)
    func popViewController(_ viewController: UIViewController, animated: Bool)
}

extension Transition where Self: UIViewController {
    
    func pushViewControler(_ viewControler: UIViewController, animated: Bool) {
        
        let transition = CATransition()
        transition.type = CATransitionType.push
        addChild(viewController: viewControler, to: self, with: self.view.bounds, animated: animated)
        viewControler.view.layer.add(transition, forKey: nil)
    }
    
    func popViewController(_ viewController: UIViewController, animated: Bool) {
        
        CATransaction.begin()
        
        CATransaction.setCompletionBlock { 
            //self.removeChild(viewController: viewController.navigationController!, animated: true)
        }
        
        let transition = CATransition()
        transition.type = CATransitionType.push
        viewController.navigationController!.view.layer.add(transition, forKey: nil)
        
        self.removeChild(viewController: viewController.navigationController!, animated: true)
        
        CATransaction.commit()
    }
    
    private func addChild(viewController: UIViewController, to parentViewController: UIViewController, with frame: CGRect, animated: Bool) {
        
        parentViewController.addChild(viewController)
        viewController.view.alpha = 1.0
        viewController.view.frame = frame
        parentViewController.view.addSubview(viewController.view)
        viewController.didMove(toParent: parentViewController)
    }
    
    private func removeChild(viewController: UIViewController, animated: Bool, completion: @escaping (() -> Void) = {}) {
        
        UIView.animate(withDuration: 0.1, animations: {
            viewController.view.alpha = 0.0
        }) { (comp) in
            viewController.willMove(toParent: nil)
            viewController.view.removeFromSuperview()
            viewController.removeFromParent()
        }
    }
}

protocol Navigation {
    
    func setup()
}

extension Navigation where Self: UIViewController {
    
    func setup() {
        
        let backArrow = #imageLiteral(resourceName: "backChevron").withRenderingMode(.alwaysTemplate)
        let backButton = UIBarButtonItem(image: backArrow, style: .plain, target: self, action: #selector(ThingDetailsViewController.didTapCloseButton))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
}

extension ThingDetailsViewController: Navigation {
    
}






