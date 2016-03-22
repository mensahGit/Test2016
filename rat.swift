//
import UIKit
class ViewController:UIViewController {
	@IBoutlet var myimageview: UIView!
	var myImages = [UIImage]()

	@IBoutlet var myButton: UIButton!


	@IBAction func doAnim(sender: AnyObject) {

		if myimageview.isAnimating(){

			//stop button is pressed
			myimageview.stopAnimating()
			myButton.setTitle("START", forState: UIControlState.Normal)
		}
		else {
			
			//start button is pressed
			myimageview.animatingDuration = 2
			myimageview.startAnimating()
			myButton.setTitle("STOP", forState: UIControlState.Normal)
		}
	}

}

override func viewDidLoad() {

	super.viewDidLoad()
}