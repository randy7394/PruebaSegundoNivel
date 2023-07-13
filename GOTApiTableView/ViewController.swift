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
        
        getData() { result in
            print(result)
        }
    }

    func getData(completion: @escaping (([APIModel]) -> Void)) {
        
        guard let url = URL(string: "https://thronesapi.com/api/v2/Characters") else {
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: URLRequest(url: url)) { data, response, error in
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

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
        cell?.textLabel?.text = data[indexPath.row].firstName
        return cell!
    }
    
    
    
}

