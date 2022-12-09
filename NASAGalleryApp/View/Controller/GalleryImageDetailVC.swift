//
//  GalleryImageDetailVC.swift
//  NASAGalleryApp
//
//  Created by Saravana kumar on 09/12/22.
//

import UIKit
import Foundation

class GalleryImageDetailVC: UIViewController {

    @IBOutlet weak var collectionVw: UICollectionView!
    @IBOutlet weak var infoView: ImageDetailInfoView!

    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    @IBAction func btnImageInfo(_ sender: UIButton) {
        
    }
}

