//
//  Cell1Con2.swift
//  FutureLove
//
//  Created by Phạm Quý Thịnh on 19/01/2024.
//

import UIKit

class Cell1Con2: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        // Tạo một instance của NextViewController
        let nextViewController = SKLoveVC()

        // Chuyển hướng sang NextViewController
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            navigationController.pushViewController(nextViewController, animated: true)
        }
    }
}
