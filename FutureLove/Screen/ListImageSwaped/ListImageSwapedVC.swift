//
//  ListImageSwapedVC.swift
//  FutureLove
//
//  Created by Phạm Quý Thịnh on 19/02/2024.
//

import UIKit

class ListImageSwapedVC: UIViewController {
    @IBOutlet weak var listImageSwapedVC: UICollectionView!
    var images : [ListImageUserSwaped] = []
    var image : ListImageUserSwaped = ListImageUserSwaped()
    override func viewDidLoad() {
        super.viewDidLoad()
        if AppConstant.userId == nil {
            // Nếu chưa đăng nhập, chuyển hướng sang màn hình đăng nhập
            self.navigationController?.pushViewController(LoginViewController(nibName: "LoginViewController", bundle: nil), animated: true)
        } 
        listImageSwapedVC.register(UINib(nibName: "CellImage", bundle: nil), forCellWithReuseIdentifier: "CellImage")
        APIService.shared.ListIMGUser(id_user: AppConstant.userId ?? 0){[weak self] image, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching videos: \(error)")
            } else {
                self.images = image
                DispatchQueue.main.async {
                    self.listImageSwapedVC.reloadData()
                }
            }

        }
    }
    
}
extension ListImageSwapedVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellImage", for: indexPath) as! CellImage
        let image = images[indexPath.item]
        if let urlString = image.link_da_swap, let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.img.image = image
                    }
                }
            }.resume()
        }
        cell.backgroundColor = UIColor.black
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = images[indexPath.row]
        let nextViewController = SwapImageImageVC()
        nextViewController.imageSwaped = images[indexPath.row]
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            navigationController.pushViewController(nextViewController, animated: true)
        }
    }
    //Name section
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return  UICollectionReusableView()
    }
}

extension ListImageSwapedVC: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthh = UIScreen.main.bounds.width
        if(UIDevice.current.userInterfaceIdiom == .pad){
            return CGSize(width: widthh/4 - 10, height: widthh/4*6)

        }
        return CGSize(width: widthh/2 - 10, height: widthh/4*3)

    }


}
