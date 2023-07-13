//
//  DetailsViewController.swift
//  GOTApiTableView
//
//  Created by Randy Morales on 12/7/23.
//

import UIKit

final class DetailsViewController: UIViewController {

    @IBOutlet var characterImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var familyNameLabel: UILabel!
    @IBOutlet var tittleLabel: UILabel!
    
    var detailViewCharacterImg = UIImage()
    var detailViewCharacterName = String()
    var detailViewCharacterFamily = String()
    var detailViewCharacterTittle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        characterImage.image = detailViewCharacterImg
        nameLabel.text = detailViewCharacterName
        familyNameLabel.text = detailViewCharacterFamily
        tittleLabel.text = detailViewCharacterTittle
        
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
