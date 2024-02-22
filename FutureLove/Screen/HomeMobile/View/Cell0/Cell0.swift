//
//  Cell0.swift
//  FutureLove
//
//  Created by Phạm Quý Thịnh on 19/01/2024.
//

import UIKit
protocol Cell0Delegate: AnyObject {
    func presentAlertController(_ alertController: UIAlertController)
}
class Cell0: UICollectionViewCell {
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    var menuOptions: [String] = ["Image Swapped", "Video Swapped", "Baby Gen"]
    weak var delegate: Cell0Delegate?

    func someMethod() {
        let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        delegate?.presentAlertController(alertController)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showMenu))
        image2.isUserInteractionEnabled = true
        image2.addGestureRecognizer(tapGesture)
        
    }
    @objc func showMenu() {
        // Hiển thị menu chọn tính năng
        let alertController = UIAlertController(title: "Select Features", message: nil, preferredStyle: .actionSheet)

        for option in menuOptions {
            let action = UIAlertAction(title: option, style: .default) { _ in
                // Xử lý khi người dùng chọn một tính năng
                self.handleSelectedOption(option)
            }
            alertController.addAction(action)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        delegate?.presentAlertController(alertController)
    }

    func handleSelectedOption(_ option: String) {
        // Xử lý khi người dùng chọn một tính năng
        switch option {
            case "Image Swapped":
                // Chuyển đến trang mới cho tính năng 1
                let nextViewController = ListImageSwapedVC()
                if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                    navigationController.pushViewController(nextViewController, animated: true)
                }
            case "Video Swapped":
                // Chuyển đến trang mới cho tính năng 2
                let nextViewController = ListSwapResultVC()
                if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                    navigationController.pushViewController(nextViewController, animated: true)
                }
            case "Baby Gen":
                // Chuyển đến trang mới cho tính năng 2
                let nextViewController = ListBabyVC()
                if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                    navigationController.pushViewController(nextViewController, animated: true)
                }
//            case "Tính năng 3":
//                // Chuyển đến trang mới cho tính năng 3
//                let vc = Feature3ViewController()
//                navigationController?.pushViewController(vc, animated: true)
            default:
                break
        }
    }

}
