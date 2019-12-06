//
//  ViewController.swift
//  SongsTableViewSearchBar
//
//  Created by C4Q  on 11/6/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit
enum SearchScope {
    case artist
    case songName
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var didSetSongs = [Song]() {
        didSet {
            tableView.reloadData()
        }
    }
    var currentScope = SearchScope.artist
    
    var searchQuary = "" {
        didSet{
            switch currentScope {
            case .artist:
                didSetSongs = Song.loveSongs.filter { $0.artist.lowercased().contains(searchQuary.lowercased())
                }
                
            case .songName:
                didSetSongs = Song.loveSongs.filter{ $0.artist.lowercased().contains(searchQuary.lowercased())}
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
    }
    func loadData() {
        didSetSongs = Song.loveSongs
        
    }
    func filterdidSetSongs(for searchText: String) {
        guard !searchText.isEmpty else { return }
        didSetSongs = Song.loveSongs.filter{ $0.artist.lowercased().contains(searchText.lowercased())}
    }

}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return didSetSongs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as? Song else {
            fatalError("error in dequeue")
        }
        let song = didSetSongs[indexPath.row]
        //cell.configureCell(For: song)
    }
}
