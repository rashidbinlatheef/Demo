import Foundation
import UIKit

extension UIImageView {
    
    func animateImage() {
        
        self.alpha = 0.0
        UIView.animate(withDuration: 1.5) {
            self.alpha = 1.0
        }
    }
}
