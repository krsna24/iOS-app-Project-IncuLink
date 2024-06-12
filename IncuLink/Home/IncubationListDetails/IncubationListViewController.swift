//
//  IncubationListViewController.swift
//  IncuLink
//
//  Created by Krsna College on 01/06/24.
//

import UIKit

class IncubationListViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var sectionNumber : Int = -1

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        label.text = DataModel.sectionHeaders[sectionNumber]
        
        
    }
}

extension IncubationListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataModel.section3a.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! IncubationSectionCollectionViewCell
        cell.incubationName.text = DataModel.section3a[indexPath.row].name
        cell.startupsIncubated.text = "Startup incubated: \(DataModel.section3a[indexPath.row].incubatedStartup)"
        cell.imageView.image = UIImage(named: DataModel.section3a[indexPath.row].thumbnailURL)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width-12
        let height = collectionView.frame.height/7
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let IncubationDetailedViewController = self.storyboard?.instantiateViewController(withIdentifier: "IncubationDetailedViewController") as! IncubationDetailedViewController
        
        IncubationDetailedViewController.image = UIImage(named: DataModel.section3b[indexPath.row].thumbnailImage!)
        
        IncubationDetailedViewController.centre = DataModel.section3b[indexPath.row].name
        
        IncubationDetailedViewController.year = "\(DataModel.section3b[indexPath.row].established)"
        
        IncubationDetailedViewController.loc = DataModel.section3b[indexPath.row].location
        
        IncubationDetailedViewController.recognisedAndFundedby = DataModel.section3b[indexPath.row].recognizedAndFundedBy
        IncubationDetailedViewController.startupsincubated = DataModel.section3b[indexPath.row].numberOfStartupsIncubated
        
        

        
        self.navigationController?.pushViewController(IncubationDetailedViewController, animated: true)
    }
}
