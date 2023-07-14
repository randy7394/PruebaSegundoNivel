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
    
    var character: APIModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = character?.fullName
        familyNameLabel.text = character?.family
        tittleLabel.text = character?.title
    
        guard let imageURL = character?.imageUrl else { return }
        characterImage.downloaded(from: imageURL)
    }
}

// funcion para descargar en la vista de detalle la imagen del JSON
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
