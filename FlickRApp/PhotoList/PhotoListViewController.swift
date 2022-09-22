//
//  ViewController.swift
//  FlickRApp
//
//  Created by Joshua on 13/09/2022.
//

import UIKit

class PhotoListViewController: UIViewController {
    var photoViewModel = PhotoViewModel()
    var defaultSearch = "Dog"

    @IBOutlet weak var photosTableView: UITableView!
    @IBOutlet weak var photoSearchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        photoSearchBar.delegate = self
        loadPicturesData(search: defaultSearch)
    }

    private func loadPicturesData(search: String) {
        photoViewModel.fetchSearchPicture(searchString: defaultSearch) { [weak self] in
            self?.photosTableView.dataSource = self
            self?.photosTableView.delegate = self
            DispatchQueue.main.async {
            self?.photosTableView.reloadData()
            }
        }
    }
}

extension PhotoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonConstants.Indentifiers.cellID, for: indexPath) as! PhotoTableViewCell
        
        let picture = photoViewModel.cellForRowAt(indexPath: indexPath)
        cell.setupCell(picture)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: CommonConstants.Indentifiers.pictureSegue, sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let destination = segue.destination as? PhotoDetailsViewController {
           let indexPath = photosTableView.indexPathForSelectedRow!
           destination.image = photoViewModel.cellForRowAt(indexPath: indexPath)
      }
    }
}

extension PhotoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchWord = searchBar.text {
            defaultSearch = searchWord
            loadPicturesData(search: searchWord)
        }
    }
}




