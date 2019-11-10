import UIKit
import Foundation

class DisplayResultViewController: UIViewController {
    var imageName: String?
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        imageView.image = UIImage(named: imageName!)
        let swipeDown =  UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe(_sender:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }

    @objc func handleSwipe(_sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "returnToFirstViewController", sender: self)
    }
}
