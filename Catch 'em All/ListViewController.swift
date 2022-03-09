//
//  ListViewController.swift
//  Catch 'em All
//
//  Created by song on 3/7/22.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
//    var creatrues = ["pikachu", "snorla", "bulbasaur", "wigglytuff"]
    
    var creatures = Creatures()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        creatures.getData {
            DispatchQueue.main.async {
                self.navigationItem.title = "\(self.creatures.creatureArray.count) of \(self.creatures.count) Pokemon"
                self.tableView.reloadData()
            }
        }
        
    }

    func loadAll() {
        if creatures.urlString.hasPrefix("http") {
            creatures.getData {
                DispatchQueue.main.async {
                    self.navigationItem.title = "\(self.creatures.creatureArray.count) of \(self.creatures.count) Pokemon"
                    self.tableView.reloadData()
                    
                }
                self.loadAll()
            }
        } else {
            print("All done - all loaded. Total Pokemon = \(creatures.creatureArray.count)")
        }
        
    }
    

    @IBAction func loadAllButtonPressed(_ sender: UIBarButtonItem) {
        
        loadAll()
        
    }
    
    
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creatures.creatureArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("\(indexPath.row + 1) of \(creatures.creatureArray.count)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if indexPath.row == creatures.creatureArray.count - 1 && creatures.urlString.hasPrefix("http") {
            creatures.getData {
                DispatchQueue.main.async {
                    self.navigationItem.title = "\(self.creatures.creatureArray.count) of \(self.creatures.count) Pokemon"
                    self.tableView.reloadData()
                }
            }
        }
        cell.textLabel?.text = "\(indexPath.row + 1). \(creatures.creatureArray[indexPath.row].name)"
        
        return cell
    }
    
    
}
