//
//  ViewController.swift
//  MarvelApp
//
//  Created by user on 04/03/23.
//

import Foundation
import UIKit
import Kingfisher
import Combine

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var observer: AnyCancellable?
    var mainViewModel = MainViewModel()
    let url = URL(string: "http://gateway.marvel.com/v1/public/characters?ts=1&apikey=c99a0bfa90957bf174792400a359a7dd&hash=da0e3c9ea128303172e7fe65eed2e63d")!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setObservers()
    }
    
    private func setObservers() {
        observer = mainViewModel.getCom(url: url)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("funcionou")
                case .failure(let error):
                    print("falhou")
                }
            }, receiveValue: { value in
                self.reload()
            })
    }
    
    private func getChars() {
        self.getCharacters(url: URL(string: "http://gateway.marvel.com/v1/public/characters?ts=1&apikey=c99a0bfa90957bf174792400a359a7dd&hash=da0e3c9ea128303172e7fe65eed2e63d")!)
    }
    
    @objc func reload() {
        self.tableView.reloadData()
    }
    
    @objc func showError() {
        print("error")
    }
    func getCharacters(url: URL) {
        self.mainViewModel.get(url: url)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height*15/100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.mainViewModel.characters != nil {
            return (self.mainViewModel.characters?.data?.results!.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CharacterCell
        if let name = self.mainViewModel.characters?.data?.results?[indexPath.row].name {
            cell.nameLabel.text = name
        }
        
        if let description = self.mainViewModel.characters?.data?.results?[indexPath.row].description {
            cell.descriptionLabel.text = description
        }
        
        if let date = self.mainViewModel.characters?.data?.results?[indexPath.row].modified {
            cell.dateLabel.text = self.dateConverter(date: date)
        }
                                
        cell.characterimageView.kf.setImage(with: self.mainViewModel.getImage(indexPath: indexPath.row))
                        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
//        let newViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//        newViewController.id = self.mainViewModel.characters?.data?.results?[indexPath.row].id
//        present(newViewController, animated: true)
    }
        
    func dateConverter(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: date)!
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }


}

