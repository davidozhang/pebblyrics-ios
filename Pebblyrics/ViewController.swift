//
//  ViewController.swift
//  Pebblyrics
//
//  Created by David on 10/31/15.
//  Copyright © 2015 David Zhang. All rights reserved.
//

import UIKit
import MediaPlayer

let pebbleConnectedNotificationKey = "pebbleConnected"
let pebbleDisconnectedNotificationKey = "pebbleDisconnected"

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var table: UITableView!
    @IBOutlet var pebbleStatus: UITextField! = UITextField()
    var songs = MPMediaQuery.songsQuery().collections
    let pebbleController = PebbleController.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setPebbleStatusConnected", name: pebbleConnectedNotificationKey, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setPebbleStatusDisconnected", name: pebbleDisconnectedNotificationKey, object: nil)
        self.setPebbleStatusDisconnected()
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
    
    func setPebbleStatusConnected() {
        if (self.pebbleStatus != nil) {
            self.pebbleStatus.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 0.6)
            self.pebbleStatus.text = "Pebble Connected"
        }
    }
    
    func setPebbleStatusDisconnected() {
        if (self.pebbleStatus != nil) {
            self.pebbleStatus.backgroundColor = UIColor(red: 0.9, green: 0, blue: 0, alpha: 0.6)
            self.pebbleStatus.text = "Pebble Not Connected"
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == "toMediaPlayerViewController" {
            let VC = segue.destinationViewController as! MediaPlayerViewController
            let indexPath: NSIndexPath = table.indexPathForSelectedRow!
            let songInfo = songs![indexPath.row].representativeItem!

            let artist: String = songInfo.artist!
            let artwork: MPMediaItemArtwork = songInfo.artwork!
            let track: String = songInfo.title!
            let fullSize = CGSizeMake(artwork.bounds.size.width, artwork.bounds.size.height)
            VC.title = track
            VC.artworkImage = songs![indexPath.row].representativeItem!.artwork?.imageWithSize(fullSize)
            if (songInfo.assetURL != nil) {
                let songURL: NSURL = songInfo.assetURL!
                VC.songURL = songURL
            }

            pebbleController.sendDictionary([NSNumber(int: 0): NSString(string: artist), NSNumber(int:1): NSString(string: track)], completionHandler: { (error) -> Void in
                print("Sent message with artist", artist, "and title", track)
            })
        }
    }
}

