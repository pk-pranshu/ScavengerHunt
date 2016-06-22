/*
Subject to Apple's Public Source License:
<http://www.opensource.apple.com/license/apsl/>
*/


import UIKit

class AddViewController: UIViewController {
    // MARK: Properties

    @IBOutlet weak var textField: UITextField!

    var newItem: ScavengerHuntItem?

    // MARK: Segue Overrides

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "DoneItem" {
            if let name = textField.text  {
                if !name.isEmpty {
                    newItem = ScavengerHuntItem(name: name)
                }
            }
        }
    }

    // MARK: Action method

    @IBAction func cancel(sender: AnyObject?) {

        dismissViewControllerAnimated(true, completion: nil)
    }
}

