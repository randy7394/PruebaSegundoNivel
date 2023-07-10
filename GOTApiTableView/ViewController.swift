//
//  ViewController.swift
//  GOTApiTableView
//
//  Created by Randy Morales on 8/7/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData() { result in
            print(result)
        }
    }

    func getData(completion: @escaping ((APIModel) -> Void)) {
        
        guard let url = URL(string: "https://thronesapi.com/api/v2/Characters") else {
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: URLRequest(url: url)) { data, response, error in
            if data != nil && error == nil {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(APIModel.self, from: data!)
                    completion(response)
                } catch {
                    print(String(describing: error))
                }
            }
        }
        task.resume()
    }
}

