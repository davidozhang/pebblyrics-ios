//
//  MediaPlayerViewController.swift
//  Pebblyrics
//
//  Created by David on 10/31/15.
//  Copyright © 2015 David Zhang. All rights reserved.
//

import AVFoundation
import UIKit
import MediaPlayer

class MediaPlayerViewController: UIViewController {

    var player: AVAudioPlayer = AVAudioPlayer()
    var toggle = true // temporary
    @IBOutlet var artwork: UIImageView!
    @IBOutlet var toolbar: UIToolbar!
    @IBAction func rewind(sender: UIBarButtonItem) {
    }
    @IBAction func playPause(sender: UIBarButtonItem) {
        var toggleBtn : UIBarButtonItem
        if toggle {
            // player.pause()
            toggleBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Pause, target: self, action: "playPause:")
            toggle = false
        } else {
            // player.play()
            toggleBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Play, target: self, action: "playPause:")
            toggle = true
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
    
    func playSong() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
}
