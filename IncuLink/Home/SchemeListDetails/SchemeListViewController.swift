//
//  SchemeListViewController.swift
//  IncuLink
//
//  Created by Krsna College on 03/06/24.
//

import UIKit
import FirebaseDatabase

class SchemeListViewController: UIViewController {
    
    var sectionNumber : Int = -1
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        label.text = "Schemes"
        
        if let navigationBar = self.navigationController?.navigationBar {
            if let imageView = navigationBar.viewWithTag(999) as? UIImageView {
                imageView.isHidden = true
            }
        }
        
        // Do any additional setup after loading the view.
        //        let ref = Database.database().reference()
        //        ref.child("SuccessAndSchemes").observe(.value) { snapshot  in
        //            guard let value = snapshot.value as? [String:Any] else{
        //                print("Data not found")
        //                return
        //            }
        //
        //            let val = value["-NzbrHh0qXffMxs_69QM"]
        ////            print(val.schemes)
        //        }
        
    }
}
extension SchemeListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HomeTabData.section2a.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SchemeSectionCollectionViewCell
        cell.imageView.image = UIImage(named : HomeTabData.section2b[indexPath.row].thumbnailImage!)
        cell.titleLabel.text = HomeTabData.section2b[indexPath.row].title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width-12
        let height = collectionView.frame.height/3
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let SchemeDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "SchemeDetailsViewController") as! SchemeDetailsViewController
        
        SchemeDetailsViewController.image = UIImage(named: HomeTabData.section2b[indexPath.row].thumbnailImage!)
        
        SchemeDetailsViewController.titlelabel = HomeTabData.section2b[indexPath.row].title
        
        SchemeDetailsViewController.desc = HomeTabData.section2b[indexPath.row].shortDescription
        
        
        
        SchemeDetailsViewController.noOfStartups = "\(HomeTabData.section2b[indexPath.row].startupSupported)"
        
        SchemeDetailsViewController.link = HomeTabData.section2b[indexPath.row].websiteLink
        
        
        self.navigationController?.pushViewController(SchemeDetailsViewController, animated: true)
    }
}
