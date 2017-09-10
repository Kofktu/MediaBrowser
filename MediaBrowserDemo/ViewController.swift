//
//  ViewController.swift
//  MediaBrowserDemo
//
//  Created by Seungyoun Yi on 2017. 9. 6..
//  Copyright © 2017년 Seungyoun Yi. All rights reserved.
//

import UIKit
import Photos
import MediaBrowser

class ViewController: UITableViewController {
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    var selections = [Bool]()
    var mediaArray = [Media]()
    var thumbs = [Media]()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.tintColor = UIColor.black
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let font = UIFont.systemFont(ofSize: 12)
        segmentedControl.setTitleTextAttributes([NSFontAttributeName: font],
                                                for: .normal)
        segmentedControl.addTarget(self, action: #selector(segmentControlChanged), for: .valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .none
    }
    
    func segmentControlChanged() {
        self.tableView.reloadData()
    }
}

//MARK: MediaBrowserDelegate
extension ViewController: MediaBrowserDelegate {
    func mediaBrowserDidFinishModalPresentation(mediaBrowser: MediaBrowser) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func thumbnail(for mediaBrowser: MediaBrowser, at index: Int) -> Media {
        if index < thumbs.count {
            return thumbs[index]
        }
        return DemoData.localMediaPhoto(imageName: "MotionBookIcon", caption: "ThumbPhoto at index is wrong")
    }
    
    func media(for mediaBrowser: MediaBrowser, at index: Int) -> Media {
        if index < mediaArray.count {
            return mediaArray[index]
        }
        return DemoData.localMediaPhoto(imageName: "MotionBookIcon", caption: "Photo at index is Wrong")
    }
    
    func numberOfMedia(in mediaBrowser: MediaBrowser) -> Int {
        return mediaArray.count
    }
    
    func isMediaSelected(at index: Int, in mediaBrowser: MediaBrowser) -> Bool {
        return selections[index]

    }
    
    func didDisplayMedia(at index: Int, in mediaBrowser: MediaBrowser) {
        print("Did start viewing photo at index \(index)")

    }
    
    func mediaDid(selected: Bool, at index: Int, in mediaBrowser: MediaBrowser) {
        selections[index] = selected
    }
    
//    func titleForPhotoAtIndex(index: Int, MediaBrowser: MediaBrowser) -> String {
//    }
    

}
//MARK: UITableViewDelegate, UITableviewDataSource
extension ViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mediaArray = [Media]()
        thumbs = [Media]()
        
        var displayActionButton = true
        var displaySelectionButtons = false
        var displayNavArrows = false
        var enableGrid = true
        var startOnGrid = false
        var autoPlayOnAppear = false
        
        switch indexPath.row {
        case 0:
            mediaArray = DemoData.singlePhoto()
            enableGrid = false
            break
        case 1:
            mediaArray = DemoData.multiplePhotoAndVideo()
            thumbs = DemoData.multiplePhotoAndVideo()
            enableGrid = false
            
            break
        case 2:
            mediaArray = DemoData.multiplePhotoGrid()
            thumbs = DemoData.multiplePhotoGrid()

            startOnGrid = true
            displayNavArrows = true
            
            break
        case 3, 4:
            mediaArray = DemoData.photoSelection()
            thumbs = DemoData.photoSelection()
            
            displayActionButton = false
            displaySelectionButtons = true
            startOnGrid = indexPath.row == 4
            enableGrid = false

            break
            
        case 5, 6:
            mediaArray = DemoData.webPhotos()
            thumbs = DemoData.webPhotos()
            
            startOnGrid = indexPath.row == 6
            break
            
        case 7:
            mediaArray = DemoData.singleVideo()
            
            enableGrid = false
            autoPlayOnAppear = true
            break
            
        case 8:
            mediaArray = DemoData.multiVideos()
            thumbs = DemoData.multiVideoThumbs()
            
            startOnGrid = true
        default:
            break
        }
        
        let browser = MediaBrowser(delegate: self)
        browser.displayActionButton = displayActionButton
        browser.displayNavArrows = displayNavArrows
        browser.displaySelectionButtons = displaySelectionButtons
        browser.alwaysShowControls = displaySelectionButtons
        browser.zoomPhotosToFill = true
        browser.enableGrid = enableGrid
        browser.startOnGrid = startOnGrid
        browser.enableSwipeToDismiss = false
        browser.autoPlayOnAppear = autoPlayOnAppear
        
        
        if displaySelectionButtons {
            selections.removeAll()
            
            for _ in 0..<mediaArray.count {
                selections.append(false)
            }
        }
        
        if segmentedControl.selectedSegmentIndex == 0 {
            self.navigationController?.pushViewController(browser, animated: true)
        } else {
            let nc = UINavigationController.init(rootViewController: browser)
            nc.modalTransitionStyle = .crossDissolve
            self.present(nc, animated: true, completion: nil)
        }
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellCheck = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        guard let cell = cellCheck else { return UITableViewCell() }
        cell.accessoryType = segmentedControl.selectedSegmentIndex == 0 ? .disclosureIndicator : .none
        
        switch (indexPath.row) {
        case 0:
            cell.textLabel?.text = "Single photo"
            cell.detailTextLabel?.text = "with caption, no grid button"
            break
        case 1:
            cell.textLabel?.text = "Multiple photos and video"
            cell.detailTextLabel?.text = "with captions"
            break
            
        case 2:
            cell.textLabel?.text = "Multiple photo grid"
            cell.detailTextLabel?.text = "showing grid first, nav arrows enabled"
            break
            
        case 3:
            cell.textLabel?.text = "Photo selections"
            cell.detailTextLabel?.text = "selection enabled"
            break
            
        case 4:
            cell.textLabel?.text = "Photo selection grid"
            cell.detailTextLabel?.text = "selection enabled, start at grid"
            break
            
        case 5:
            cell.textLabel?.text = "Web photos"
            cell.detailTextLabel?.text = "photos from web"
            break
            
        case 6:
            cell.textLabel?.text = "Web photo grid"
            cell.detailTextLabel?.text = "showing grid first"
            break
            
        case 7:
            cell.textLabel?.text = "Single video"
            cell.detailTextLabel?.text = "with auto-play"
            break
            
        case 8:
            cell.textLabel?.text = "Web videos"
            cell.detailTextLabel?.text = "showing grid first"
            break
            
        default: break
        }
        
        return cell
    }
}

