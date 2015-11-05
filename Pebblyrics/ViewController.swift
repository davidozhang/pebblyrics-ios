//
//  ViewController.swift
//  Pebblyrics
//
//  Created by David on 10/31/15.
//  Copyright © 2015 David Zhang. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    var songs = MPMediaQuery.songsQuery().collections

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = songs![indexPath.row].representativeItem!.title
        cell.imageView!.image = songs![indexPath.row].representativeItem!.artwork?.imageWithSize(CGSizeMake(10, 10))
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("toMediaPlayerViewController", sender: tableView)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toMediaPlayerViewController" {
            let VC = segue.destinationViewController as! MediaPlayerViewController
            let indexPath: NSIndexPath = table.indexPathForSelectedRow!
            
            VC.title = songs![indexPath.row].representativeItem!.title
            let songURL: NSURL = songs![indexPath.row].representativeItem!.assetURL!
            VC.songURL = songURL
            let artwork: MPMediaItemArtwork = songs![indexPath.row].representativeItem!.artwork!
            let fullSize = CGSizeMake(artwork.bounds.size.width, artwork.bounds.size.height)
            VC.artworkImage = songs![indexPath.row].representativeItem!.artwork?.imageWithSize(fullSize)
        }
    }
}

