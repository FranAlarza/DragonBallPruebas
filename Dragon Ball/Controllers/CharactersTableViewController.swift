//
//  CharactersTableViewController.swift
//  Dragon Ball
//
//  Created by Fran Alarza on 10/7/22.
//

import UIKit

class CharactersTableViewController: UITableViewController {
    
    @IBOutlet var charactersTable: UITableView!
    var heroes: [Hero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let xib = UINib.init(nibName: "TableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "CharacterViewCell")
        title = "Table of Heroes"
        
        let networkModel = NetworkModel.shared
        networkModel.getCharacter { heroes, error in
            self.heroes = heroes
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return heroes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.setDataCell(model: heroes[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = DetailViewController()
        nextVC.setModel(model: heroes[indexPath.row])
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}
