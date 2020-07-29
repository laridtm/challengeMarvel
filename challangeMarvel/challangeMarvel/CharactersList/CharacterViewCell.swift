//
//  CharacterViewCell.swift
//  challangeMarvel
//
//  Created by Larissa Diniz on 28/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import UIKit

class CharacterViewCell: UICollectionViewCell {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    
    let httpClient = HTTPClient()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        layer.cornerRadius = 8
    }
    
    func setImage(url: String) {
        if let apiUrl = URL(string: url) {
            httpClient.get(url: apiUrl) { result -> Void in
                switch result {
                case .failure:
                    break
                case .success(let data):
                    DispatchQueue.main.async {
                        let loadedImage = UIImage(data: data)
                        self.characterImage.image = loadedImage
                    }
                    break
                }
            }
        }
    }
    
    func setName(name: String) {
        characterName.text = name
    }
}
