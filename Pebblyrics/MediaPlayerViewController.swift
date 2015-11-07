//
//  MediaPlayerViewController.swift
//  Pebblyrics
//
//  Created by David on 10/31/15.
//  Copyright © 2015 David Zhang. All rights reserved.
//

import AVFoundation
import MediaPlayer
import UIKit

class MediaPlayerViewController: UIViewController {

    var player: AVPlayer = AVPlayer()
    var artworkImage: UIImage!
    var songURL: NSURL!
    @IBOutlet var artwork: UIImageView!
    @IBOutlet var toolbar: UIToolbar!
    @IBAction func rewind(sender: UIBarButtonItem) {
    }
    @IBAction func playPause(sender: UIBarButtonItem) {
        var toggleBtn : UIBarButtonItem
        if player.rate > 0 {
            player.pause()
            toggleBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Play, target: self, action: "playPause:")
        } else {
            player.play()
            toggleBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Pause, target: self, action: "playPause:")
        }
        var items = toolbar.items!
        items[1] = toggleBtn
        toolbar.setItems(items, animated: true)
    }
    @IBAction func forward(sender: UIBarButtonItem) {
        
    }
    @IBAction func action(sender: UIBarButtonItem) {
    }
    @IBOutlet var volume: UISlider!
    @IBAction func volumeAction(sender: UISlider) {
        player.volume = volume.value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        if songURL != nil {
            player = AVPlayer(playerItem: AVPlayerItem(URL: songURL))
            player.play()
            
            var items = toolbar.items!
            items[1] = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Pause, target: self, action: "playPause:")
            toolbar.setItems(items, animated: true)
        }
        
        artwork.image = artworkImage
        artwork.contentMode = .ScaleAspectFit
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
