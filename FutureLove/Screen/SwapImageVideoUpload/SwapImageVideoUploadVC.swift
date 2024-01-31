//
//  SwapImageVideoUploadVC.swift
//  FutureLove
//
//  Created by Phạm Quý Thịnh on 31/01/2024.
//

import UIKit
import SETabView

class SwapImageVideoUploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SETabItemProvider {
    var seTabBarItem: UITabBarItem? {
        return UITabBarItem(title: "", image: R.image.tab_video(), tag: 0)
    }

    @IBOutlet weak var plush1: UIImageView!
    @IBOutlet weak var plush2: UIImageView!
    @IBOutlet weak var imageUpload: UIImageView!
    @IBOutlet weak var videoUpload: UIView!
    @IBOutlet weak var backGroundBtn: UIImageView!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnDownload: UIButton!
    var uploadImageView: UIImageView?
    var selectedImageView: UIImageView?
    //var currentImageType: CheckImageType = .first
    var image_Data:UIImage = UIImage()
    var video_Data:UIImage = UIImage()
    var imageLink: String = ""
    var videoLink: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = UIScreen.main.bounds
        gradientLayer.colors = [
            UIColor(red: 229/255.0, green: 166/255.0, blue: 190/255.0, alpha: 1.0).cgColor,
            UIColor(red: 171/255.0, green: 122/255.0, blue: 203/255.0, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        view.layer.insertSublayer(gradientLayer, at: 0)
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(imageUpdateTapped(_:)))
        plush1.isUserInteractionEnabled = true
        plush1.addGestureRecognizer(tapGesture1)
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(imageUpdateTapped(_:)))
        plush2.isUserInteractionEnabled = true
        plush2.addGestureRecognizer(tapGesture2)

    }

    @objc func imageUpdateTapped(_ sender: UITapGestureRecognizer) {
        // Xác định ImageView tương ứng với sự kiện tap
        if sender.view == plush1 || sender.view == imageUpload {
            selectedImageView = plush1
            //currentImageType = .first
            uploadImageView = imageUpload

        } 
//        else if sender.view == plush2 || sender.view == imageUpload2 {
//            selectedImageView = plush2
//            currentImageType = .second
//            uploadImageView = imageUpload2

//        }

        showImagePicker()
    }

    func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        if let viewController = self.findViewController() {
            viewController.present(imagePicker, animated: true, completion: nil)
        }

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // Thay thế ảnh vào ImageView tương ứng
            //if self.currentImageType == .first {
                picker.dismiss(animated: true)
                plush1.isHidden = true
                self.detectFaces(in: selectedImage)
//            } else {
//                picker.dismiss(animated: true)
//                plush2.isHidden = true
//                self.detectFaces(in: selectedImage)
//            }
            uploadImageView?.image = selectedImage
            configureImageView(uploadImageView!)
            picker.dismiss(animated: true, completion: nil)
        } else {
            print("Image not found")
        }

    }
    func detectFaces(in image: UIImage)  {

//        if self.currentImageType == .first {
            self.imageUpload.image = UIImage(named: "icon-upload")
            self.uploadGenLoveByImages(is1: true, image_Data: image){data,error in
                if let data = data as? String{
                    let Old1Link = data//.replacingOccurrences(of: "/var/www/build_futurelove", with: "https://futurelove.online")
                    print("1: \(Old1Link)")
                    self.imageLink = Old1Link
                }
            }
//        }else{
//            self.imageUpload2.image = UIImage(named: "icon-upload")
//            self.uploadGenLoveByImages(is1: false, image_Data: image){data,error in
//                if let data = data as? String{
//                    let Old2Link = data//.replacingOccurrences(of: "/var/www/build_futurelove", with: "https://futurelove.online")
//                    print("2: \(Old2Link)")
//                    self.image2Link = Old2Link
//                }
//            }
//        }

    }

    func uploadGenLoveByImages(is1:Bool,image_Data:UIImage,completion: @escaping ApiCompletion){
        APIService.shared.UploadImagesToGenRieng("https://metatechvn.store/upload-gensk/" + String(AppConstant.userId ?? 0) + "?type=src_vid", ImageUpload: image_Data,method: .POST, loading: true){data,error in
            print("uploadding")
            completion(data, nil)
            print("done")
        }
    }

    private func configureImageView(_ imageView: UIImageView) {
        imageView.layer.cornerRadius = 8 // Half of your desired diameter
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 121),
            imageView.heightAnchor.constraint(equalToConstant: 142)
        ])
    }



}
