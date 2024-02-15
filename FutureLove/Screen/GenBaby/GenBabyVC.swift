//
//  GenBabyVC.swift
//  FutureLove
//
//  Created by Phạm Quý Thịnh on 15/02/2024.
//

import UIKit

class GenBabyVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var plusNam: UIImageView!
    @IBOutlet weak var plusNu: UIImageView!
    @IBOutlet weak var imageNam: UIImageView!
    @IBOutlet weak var imageNu: UIImageView!
    @IBOutlet weak var imageLove: UIImageView!
    @IBOutlet weak var bgrStart: UIImageView!
    @IBOutlet weak var bgrDowload: UIImageView!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnDowload: UIButton!
    @IBOutlet weak var boyNameTextField: UITextField!
    @IBOutlet weak var girlNameTextField: UITextField!
    @IBOutlet weak var arrowNam: UIImageView!
    @IBOutlet weak var arrowNu: UIImageView!
    let spinner = UIActivityIndicatorView(style: .large)
    var image_Data_Nam:UIImage = UIImage()
    var image_Data_Nu:UIImage = UIImage()
    var imageboyLink: String = ""
    var imageGirlLink: String = ""
    var selectedImageView: UIImageView?
    var uploadImageView: UIImageView?
    var currentImageType: ChooseImageType = .boy
    var imageBabyUrl: String = ""
    var checkNam: Bool = false
    var checkNu: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        if AppConstant.userId == nil {
            // Nếu chưa đăng nhập, chuyển hướng sang màn hình đăng nhập
            self.navigationController?.pushViewController(LoginViewController(nibName: "LoginViewController", bundle: nil), animated: true)
        }

        self.unreplace()

        let tapGestureNam = UITapGestureRecognizer(target: self, action: #selector(imageUpdateTapped(_:)))
        plusNam.isUserInteractionEnabled = true
        plusNam.addGestureRecognizer(tapGestureNam)
        let tapGestureNam2 = UITapGestureRecognizer(target: self, action: #selector(imageUpdateTapped(_:)))
        imageNam.isUserInteractionEnabled = true
        imageNam.addGestureRecognizer(tapGestureNam2)
        let tapGestureNu = UITapGestureRecognizer(target: self, action: #selector(imageUpdateTapped(_:)))
        plusNu.isUserInteractionEnabled = true
        plusNu.addGestureRecognizer(tapGestureNu)
        let tapGestureNu2 = UITapGestureRecognizer(target: self, action: #selector(imageUpdateTapped(_:)))
        imageNu.isUserInteractionEnabled = true
        imageNu.addGestureRecognizer(tapGestureNu2)

    }

    @objc func imageUpdateTapped(_ sender: UITapGestureRecognizer) {
        // Xác định ImageView tương ứng với sự kiện tap
        if sender.view == plusNam || sender.view == imageNam {
            selectedImageView = plusNam
            currentImageType = .boy
            uploadImageView = imageNam
        } else if sender.view == plusNu || sender.view == imageNu {
            selectedImageView = plusNu
            currentImageType = .girl
            uploadImageView = imageNu
        }

        showImagePicker()
    }

    func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        if let viewController = self.findViewController() {
            viewController.present(imagePicker, animated: true, completion: nil)
        }

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // Thay thế ảnh vào ImageView tương ứng

            if self.currentImageType == .boy {
                picker.dismiss(animated: true)
                imageNam.image = selectedImage
                checkNam = true
                unreplace()
                self.detectFaces(in: selectedImage)
            } else {
                picker.dismiss(animated: true)
                imageNu.image = selectedImage
                checkNu = true
                unreplace()
                self.detectFaces(in: selectedImage)
            }
            uploadImageView?.image = selectedImage
            configureImageView(uploadImageView!)
            picker.dismiss(animated: true, completion: nil)
        } else {
            print("Image not found")
        }

    }

    func detectFaces(in image: UIImage)  {

        if self.currentImageType == .boy {
            self.imageNam.image = UIImage(named: "icon-upload")
            self.uploadGenLoveByImages(isNam: true, image_Data: image){ [self]data,error in
                if let data = data as? String{
                    let OldBoyLink = data/*.replacingOccurrences(of: "/var/www/build_futurelove", with: "https://futurelove.online")*/
                    print("B: \(OldBoyLink)")
                    self.imageboyLink = OldBoyLink
                    self.image_Data_Nam = image
                    self.plusNam.isHidden = true
                }
                else{
                    self.showAlert(title: "Lỗi", message: "Vui lòng tải lên ảnh hợp lệ")
                }
            }
        }else{
            self.imageNu.image = UIImage(named: "icon-upload")
            self.uploadGenLoveByImages(isNam: false, image_Data: image){data,error in
                if let data = data as? String{
                    let OldGirlLink = data/*.replacingOccurrences(of: "/var/www/build_futurelove", with: "https://futurelove.online")*/
                    print("G: \(OldGirlLink)")
                    self.imageGirlLink = OldGirlLink
                    self.image_Data_Nu = image
                    self.plusNu.isHidden = true
                }
                else{
                    self.showAlert(title: "Lỗi", message: "Vui lòng tải lên ảnh hợp lệ")
                }
            }
            //self.image_Data_Nu = image
        }

    }

    func uploadGenLoveByImages(isNam:Bool,image_Data:UIImage,completion: @escaping ApiCompletion){
        var checkNamNu = ""
        if isNam == true{
            checkNamNu = "?type=src_nam"
        }else{
            checkNamNu = "?type=src_nu"
        }
        APIService.shared.UploadImagesToGenRieng("https://metatechvn.store/upload-gensk/" + String(AppConstant.userId ?? 0) + checkNamNu, ImageUpload: image_Data,method: .POST, loading: true){data,error in
            if let error = error {
                self.showAlert(title: "Lỗi", message: "Vui lòng tải lên ảnh hợp lệ")
            }
            else{
                print("uploadding")
                completion(data, nil)
                print("done")
            }

        }
    }

    private func configureImageView(_ imageView: UIImageView) {
        imageView.layer.cornerRadius = 40 // Half of your desired diameter
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    private func configureImageView2(_ imageView: UIImageView) {
        imageView.layer.cornerRadius = 60 // Half of your desired diameter
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    @IBAction func startEventBtn(_ sender: Any){
        if(!checkNu || !checkNam){
            showAlert(title: "Lỗi", message: "Vui lòng tải lên đủ ảnh hoặc ảnh hợp lệ")
        }
        else{
            spinner.center = view.center
            view.addSubview(spinner)
            spinner.startAnimating()
            APIService.shared.GenBaby(device_them_su_kien: AppConstant.modelName ?? "iphone", ip_them_su_kien: AppConstant.IPAddress.asStringOrEmpty(), id_user: AppConstant.userId.asStringOrEmpty(), linknam: imageboyLink, linknu: imageGirlLink){(response, error) in
                if let error = error {
                    print("Erro create image: \(error)")
                } else {
                    print("Done \(response)")
                    if let urlString = response?.link_da_swap, let url = URL(string: urlString) {
                        URLSession.shared.dataTask(with: url) { (data, response, error) in
                            if let data = data, let image = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self.imageBabyUrl = urlString
                                    self.imageLove.image = image
                                    self.configureImageView2(self.imageLove)
                                    self.replace()
                                    self.spinner.stopAnimating()
                                }
                            }
                        }.resume()
                    }
                }
            }
        }

    }
    @IBAction func dowloadEventBtn(_ sender: Any){
        guard let imageUrl = URL(string: imageBabyUrl) else {
            return
        }

        // Tải xuống dữ liệu hình ảnh từ URL
        URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            if let error = error {
                print("Lỗi tải xuống ảnh: \(error.localizedDescription)")
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                print("Dữ liệu ảnh không hợp lệ.")
                return
            }

            // Lưu ảnh vào thư viện ảnh của thiết bị
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }.resume()
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Lỗi khi lưu ảnh vào thư viện: \(error.localizedDescription)")

            // Hiển thị thông báo khi lưu thất bại
            showAlert(title: "Lỗi", message: "Không thể lưu ảnh. Vui lòng thử lại.")
        } else {
            print("Lưu ảnh thành công.")

            // Hiển thị thông báo khi lưu thành công
            showAlert(title: "Thành công", message: "Ảnh đã được lưu vào thư viện.")
        }
    }
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    func replace(){
        self.arrowNam.isHidden = false
        self.arrowNu.isHidden = false
        self.btnStart.isHidden = true
        self.btnDowload.isHidden = false
        self.bgrStart.isHidden = true
        self.bgrDowload.isHidden = false
    }
    func unreplace(){
        self.arrowNam.isHidden = true
        self.arrowNu.isHidden = true
        self.btnStart.isHidden = false
        self.btnDowload.isHidden = true
        self.bgrStart.isHidden = false
        self.bgrDowload.isHidden = true
    }

}
extension GenBabyVC {
    enum ChooseImageType {
        case boy
        case girl
    }
}

