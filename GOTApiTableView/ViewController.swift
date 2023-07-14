//
//  ViewController.swift
//  GOTApiTableView
//
//  Created by Randy Morales on 8/7/23.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var tableView: UITableView!
    
    var data = [APIModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        registerTable()
        super.viewDidLoad()
        
        getData { data in
            self.data = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func registerTable () {
        let cell = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "TableViewCell")
    }

    func getData(completion: @escaping (([APIModel]) -> Void)) {
        
        let urlstring = "https://thronesapi.com/api/v2/Characters"
        guard let url = URL(string: urlstring) else {
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if data != nil && error == nil {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode([APIModel].self, from: data!)
                    completion(response)
                } catch {
                    print(String(describing: error))
                }
            }
        }
        task.resume()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell {
            
            cell.cellFullName.text = data[indexPath.row].fullName
            cell.cellFamilyName.text = data[indexPath.row].family
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let secondViewController = storyboard?.instantiateViewController(identifier:"DetailsViewController") as? DetailsViewController {
            secondViewController.character = data[indexPath.row]
            self.navigationController?.pushViewController(secondViewController, animated: true)
            
        }
    }
    
}
