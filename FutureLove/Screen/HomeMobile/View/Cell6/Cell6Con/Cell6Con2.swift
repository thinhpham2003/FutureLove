//
//  Cell6Con2.swift
//  FutureLove
//
//  Created by Phạm Quý Thịnh on 19/01/2024.
//

import UIKit

class Cell6Con2: UICollectionViewCell {
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!   
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        // Tạo một instance của NextViewController
        let nextViewController = SwapImage_VideoTemplateVC()

        // Chuyển hướng sang NextViewController
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            navigationController.pushViewController(nextViewController, animated: true)
        }
    }
}
