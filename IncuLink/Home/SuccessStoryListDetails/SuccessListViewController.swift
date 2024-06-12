//
//  SectionDetailedViewController.swift
//  IncuLink
//
//  Created by Krsna College on 28/05/24.
//

import UIKit

class SectionDetailedViewController: UIViewController {
    
    var sectionNumber : Int = -1
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        label.text = HomeTabData.sectionHeaders[sectionNumber]
        
        if let navigationBar = self.navigationController?.navigationBar {
            if let imageView = navigationBar.viewWithTag(999) as? UIImageView {
                imageView.isHidden = true
            }
        }
        
        
    }
}

extension SectionDetailedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HomeTabData.section1a.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SectionCollectionViewCell
        cell.startupNameLabel.text = HomeTabData.section1a[indexPath.row].name
        cell.incubationUsedLabel.text = HomeTabData.section1a[indexPath.row].incubationName
        cell.foundedYearLabel.text = "\(HomeTabData.section1a[indexPath.row].foundedYear)"
        cell.imageView.image = UIImage(named: HomeTabData.section1a[indexPath.row].thumbnailURL)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width-15
        let height = collectionView.frame.height/5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let successStoryDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "SuccesStoryDetailedViewController") as! SuccesStoryDetailedViewController
        
        successStoryDetailViewController.startupLogo = UIImage(named: HomeTabData.section1b[indexPath.row].thumbnailImage!)
        
        successStoryDetailViewController.startupName = HomeTabData.section1b[indexPath.row].name
        
        successStoryDetailViewController.founderName = HomeTabData.section1b[indexPath.row].founders
        
        successStoryDetailViewController.incubationUsed = HomeTabData.section1b[indexPath.row].incubationUsed
        
        successStoryDetailViewController.schemeUsed = HomeTabData.section1b[indexPath.row].schemes
        
        successStoryDetailViewController.domain = HomeTabData.section1b[indexPath.row].domain
        
        successStoryDetailViewController.publicRating = "\(HomeTabData.section1b[indexPath.row].publicRating)"
        
        
        self.navigationController?.pushViewController(successStoryDetailViewController, animated: true)
    }
}
