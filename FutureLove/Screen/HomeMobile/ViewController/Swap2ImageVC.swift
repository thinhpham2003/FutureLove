//
//  Swap2ImageVC.swift
//  FutureLove
//
//  Created by Phạm Quý Thịnh on 17/01/2024.
//

import UIKit
import SETabView

class Swap2ImageVC: UIViewController, SETabItemProvider, Cell0Delegate {
    func presentAlertController(_ alertController: UIAlertController) {
        present(alertController, animated: true, completion: nil)
    }

    var seTabBarItem: UITabBarItem? {
        return UITabBarItem(title: "", image: R.image.tab_video(), tag: 0)
    }
    var gradientLayer = CAGradientLayer()
    @IBOutlet weak var collectionViewMain: UICollectionView!
    let cellNames = ["Cell0", "Cell1", "Cell2", "Cell3", "Cell4", "Cell5", "Cell6"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Tạo một view mới để chứa gradient layer
        let gradientView = UIView(frame: UIScreen.main.bounds)

        // Thêm gradient layer vào view mới
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [
            UIColor(red: 229/255.0, green: 166/255.0, blue: 190/255.0, alpha: 1.0).cgColor,
            UIColor(red: 171/255.0, green: 122/255.0, blue: 203/255.0, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientView.layer.insertSublayer(gradientLayer, at: 0)

        // Đặt view chứa gradient layer vào phía sau của tất cả các view khác trên màn hình
        view.insertSubview(gradientView, at: 0)

        collectionViewMain.backgroundColor = UIColor.clear

        for cellName in cellNames {
            collectionViewMain.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }


}

extension Swap2ImageVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellNames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cellName = cellNames[indexPath.row % cellNames.count]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath)
        cell.backgroundColor = UIColor(white: 1, alpha: 0.3)
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        if let cell0 = cell as? Cell0 {
            // Nếu đúng, thiết lập Swap2ImageVC làm delegate cho Cell0
            cell0.delegate = self
        }
        return cell
    }
    
    //Name section
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return  UICollectionReusableView()
    }
}

extension Swap2ImageVC: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.row == 0){
            return CGSize(width: UIScreen.main.bounds.width - 10, height: 100)
        }
        if(UIDevice.current.userInterfaceIdiom == .pad){
            return CGSize(width: UIScreen.main.bounds.width - 10, height: 365)

        }
        return CGSize(width: UIScreen.main.bounds.width - 10, height: 760)
    }
}

