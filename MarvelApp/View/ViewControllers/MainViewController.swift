//
//  ViewController.swift
//  MarvelApp
//
//  Created by user on 04/03/23.
//

import UIKit

class MainViewController: UIViewController {

    var mainViewModel = MainViewModel()
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getCharacters(url: URL(string: "http://gateway.marvel.com/v1/public/characters?ts=1&apikey=c99a0bfa90957bf174792400a359a7dd&hash=da0e3c9ea128303172e7fe65eed2e63d")!)
    }
        
    func getCharacters(url: URL) {
//        self.mainViewModel.get(url: url).subscribe(
//            onNext: { result in
//                self.tableView.reloadData()
//                //self.showLoading(false)
//            },
//            onError: { error in
//                //self.showAlert(title: "Erro", message: "Ocorreu o seguinte erro - \(error.localizedDescription) ")
//                
//            },
//            onCompleted: { }
//        ).disposed(by: disposeBag)
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
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let newViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        newViewController.id = self.mainViewModel.characters?.data?.results?[indexPath.row].id
        present(newViewController, animated: true)
    }
        
    func dateConverter(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: date)!
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }


}

