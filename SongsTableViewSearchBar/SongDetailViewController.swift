//
//  SongDetailViewController.swift
//  SongsTableViewSearchBar
//
//  Created by Margiett Gil on 12/6/19.
//  Copyright © 2019 C4Q . All rights reserved.
//

import UIKit

class SongDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var  artistNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    
    var selectedSong: Song?

 override func viewDidLoad() {
        super.viewDidLoad()

        artistNameLabel.text = selectedSong?.artist
        songNameLabel.text = selectedSong?.name
       
        
    }
    

 


}
