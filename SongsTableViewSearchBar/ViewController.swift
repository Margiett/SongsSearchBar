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
    
    var searchQuary = "" { // this is what is holding the search
        didSet{
            switch currentScope {
            case .artist:
                didSetSongs = Song.loveSongs.filter { $0.artist.lowercased().contains(searchQuary.lowercased())
                }
                
            case .songName:
                didSetSongs = Song.loveSongs.filter{ $0.name.lowercased().contains(searchQuary.lowercased())}
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
    // this was suppose to filter the songs by song name and by artist 
    func filterdidSetSongs(for searchText: String) {
        guard !searchText.isEmpty else { return }
        didSetSongs = Song.loveSongs.filter{ $0.artist.lowercased().contains(searchText.lowercased())}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let songDetailViewController = segue.destination as? SongDetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("issues with prepare for segue")
        }
        // needs to call on the detail view controller's variable to then assign to this view controller's data
        songDetailViewController.selectedSong = didSetSongs[indexPath.row]
}
}
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            loadData()
            return
        }
        searchQuary = searchText
        
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print("inside of selected ScopeButtonIndex")
        print(selectedScope)

        switch selectedScope{
        case 0:
            currentScope = .artist
        case 1:
            currentScope = .songName
        default:
            print("not within scope")
        }
        
        
    }
    
    // i dont know what this is doing ?? 
    func searchBar (_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()



    }
}


extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if didSetSongs.count == 0 {
            searchBar.resignFirstResponder()
            tableView.tintColor = .red
            navigationItem.title = "You have entered an invailed search Please try again "
        }
        return didSetSongs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        let song = didSetSongs[indexPath.row]
        
       
        cell.textLabel?.text = song.artist
    
        cell.detailTextLabel?.text = song.name
    
        //cell.configureCell(For: song)
        return cell
        
    }
}
