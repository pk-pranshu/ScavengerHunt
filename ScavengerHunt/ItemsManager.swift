/*
Subject to Apple's Public Source License:
<http://www.opensource.apple.com/license/apsl/>
*/


import Foundation

class ItemsManager {
    // MARK: Properties

    var items = [ScavengerHuntItem]()

    // MARK: Initializers

    init() {
        unarchiveSavedItems()
    }

    // MARK: Saving
    func save() {
        NSKeyedArchiver.archiveRootObject(items, toFile: archivePath)
    }

    // MARK: Private Convenience

    private func unarchiveSavedItems() {
        if NSFileManager.defaultManager().fileExistsAtPath(archivePath) {
            let savedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(archivePath) as [ScavengerHuntItem]

            items += savedItems
        }
    }

    lazy private var archivePath: String = {
        let fileManager = NSFileManager.defaultManager()

        let documentsDirectoryURLs = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as [NSURL]
        
        let archiveURL = documentsDirectoryURLs.first!.URLByAppendingPathComponent("ScavengerHuntItems", isDirectory: false)

        return archiveURL.path!
    }()
}
