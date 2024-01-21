//
//  StartViewController.swift
//  FutureLove
//
//  Created by TTH on 01/08/2023.
//

import UIKit
import DeviceKit

class StartViewController: UIViewController {

    @IBOutlet weak var luonSong2Image: UIImageView!
    @IBOutlet weak var luonSongImage: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let device = Device.current
        let modelName = device.description
        AppConstant.modelName = modelName

        UIView.animate(withDuration: 3.0, animations: {
            self.luonSongImage.transform = CGAffineTransform(translationX: -150 , y: -200)
        }) { _ in

        }
        UIView.animate(withDuration: 3.0, animations: {
            self.luonSong2Image.transform = CGAffineTransform(translationX: 160 , y: -210)
        }) { _ in
            if AppConstant.userId == nil {
                self.navigationController?.pushViewController(LoginViewController(nibName: "LoginViewController", bundle: nil), animated: true)
            } else {
                self.navigationController?.setRootViewController(viewController: TabbarViewController(),
                                                                 controllerType: TabbarViewController.self)
            }

        }
        let imageData = luonSong2Image.image!.jpegData(compressionQuality: 1.0)
    }

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let device = Device.current
//        let modelName = device.description
//        AppConstant.modelName = modelName
//        
//        UIView.animate(withDuration: 3.0, animations: {
//            self.luonSongImage.transform = CGAffineTransform(translationX: -150 , y: -200)
//                }) { _ in
//                    
//                }
//        UIView.animate(withDuration: 3.0, animations: {
//            self.luonSong2Image.transform = CGAffineTransform(translationX: 160 , y: -210)
//                }) { _ in
//                    if AppConstant.userId == nil {
//                        self.navigationController?.pushViewController(LoginViewController(nibName: "LoginViewController", bundle: nil), animated: true)
//                    } else {
//                        self.navigationController?.setRootViewController(viewController: TabbarViewController(),
//                                                                         controllerType: TabbarViewController.self)
//                    }
//                    
//                }
//        let imageData = luonSong2Image.image!.jpegData(compressionQuality: 1.0)
//        
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let device = Device.current
//        let modelName = device.description
//        AppConstant.modelName = modelName
//
//        UIView.animate(withDuration: 3.0, animations: {
//            self.luonSongImage.transform = CGAffineTransform(translationX: -150 , y: -200)
//        }) { _ in
//            // Code sau khi animation hoàn thành (nếu cần)
//        }
//
//        UIView.animate(withDuration: 3.0, animations: {
//            self.luonSong2Image.transform = CGAffineTransform(translationX: 160 , y: -210)
//        }) { _ in
//            if AppConstant.userId == nil {
//                // Sử dụng nib name để khởi tạo Swap2ImageVC
//                let swap2ImageVC = Swap2ImageVC(nibName: "Swap2ImageVC", bundle: nil)
//                self.navigationController?.pushViewController(swap2ImageVC, animated: true)
//            } else {
//                // Thay đổi root view controller thành TabbarViewController
//                let tabbarVC = TabbarViewController()
//                self.navigationController?.setRootViewController(viewController: tabbarVC, controllerType: TabbarViewController.self)
//            }
//        }
//
//        let imageData = luonSong2Image.image!.jpegData(compressionQuality: 1.0)
//    }

}
