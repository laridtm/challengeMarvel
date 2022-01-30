import Foundation
import UIKit

extension UIImageView {
    func setImage(url: String) {
        let httpClient = HTTPClient()
        
        if let apiUrl = URL(string: url) {
            httpClient.get(url: apiUrl) { result -> Void in
                switch result {
                case .failure:
                    break
                case .success(let data):
                    DispatchQueue.main.async {
                        let loadedImage = UIImage(data: data)
                        self.image = loadedImage
                    }
                    break
                }
            }
        }
    }
}
