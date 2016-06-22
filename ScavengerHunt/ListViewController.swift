/*
Subject to Apple's Public Source License:
<http://www.opensource.apple.com/license/apsl/>
*/


import UIKit

class ListViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: Properties

    let itemsManager = ItemsManager()

    // MARK: UITableViewDataSource

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsManager.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell", forIndexPath: indexPath) as UITableViewCell

        let item = itemsManager.items[indexPath.row]
        cell.textLabel?.text = item.name

        if (item.isComplete) {
            cell.accessoryType = .Checkmark
            cell.imageView?.image = item.photo
        } else {
            cell.accessoryType = .None
            cell.imageView?.image = nil
        }

        return cell
    }

    // MARK: UITableViewDelegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let imagePicker = UIImagePickerController()

        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }

        imagePicker.delegate = self

        presentViewController(imagePicker, animated: true, completion: nil)
    }

    // MARK: Segues

    @IBAction func unwindToList(segue: UIStoryboardSegue) {

        if segue.identifier == "DoneItem" {

            let addItemController = segue.sourceViewController as AddViewController
            if let newItem = addItemController.newItem {
                itemsManager.items.append(newItem)
                itemsManager.save()
                let insertionRow = itemsManager.items.count-1
                let indexPath = NSIndexPath(forRow:insertionRow , inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation:.Automatic)
            }
        }
    }

    // MARK: UIImagePickerControllerDelegate

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: NSDictionary) {

        let indexPath = tableView.indexPathForSelectedRow()!
        let selectedItem = itemsManager.items[indexPath.row]

        selectedItem.photo = info[UIImagePickerControllerOriginalImage] as? UIImage
        itemsManager.save()

        dismissViewControllerAnimated(true, completion:{
            self.tableView.deselectRowAtIndexPath(indexPath, animated:true)
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation:.Automatic)
        })
    }
}
