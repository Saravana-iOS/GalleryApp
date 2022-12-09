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

    var imgInfoViewModel : ImageViewModel!
    
    private var infoDataSource : ImageCollectionDataSource<ImageCell,ImageModel>!
    var countCell : CGFloat = 1.0

    var selectedItem : Int = 0
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupUI()
    }
    
    func setupUI() {
        collectionVw.register(ImageCell.self, forCellWithReuseIdentifier: "cellIdentifier")
        collectionVw.delegate = self
        self.loadColletion()
    }
    
    func loadColletion(){
        self.infoDataSource = ImageCollectionDataSource(cellIdentifier: "cellIdentifier", items: self.imgInfoViewModel.imgData, configureCell: { (cell, imgData) in
            
            cell.galleryImage.loadImageUsingCache(withURLStr: imgData.url)
        })
        
        DispatchQueue.main.async {
            self.collectionVw.dataSource = self.infoDataSource
            self.collectionVw.reloadData()
            if self.imgInfoViewModel.imgData.count > 0 {
                self.collectionVw.scrollToItem(at: IndexPath(row: self.selectedItem, section: 0), at: .centeredHorizontally, animated: false)
            }
        }
    }

    @IBAction func btnImageInfo(_ sender: UIButton) {
        self.openInfoView()
    }
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        self.closeInfoView()
    }
    
    func openInfoView(){
        self.infoView.frame = self.view.bounds
        self.infoView.frame.origin.y = UIScreen.main.bounds.height
        self.view.addSubview(self.infoView)
        self.infoView.detailView.layer.cornerRadius = 20
        self.infoView.detailView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.loadInfoDetails()
        self.infoView.viewAnimationUp(isAppear: true, maxYValuel: 0) { Done in
            
        }
    }
    func closeInfoView(){
        self.infoView.viewAnimationUp(isAppear: false, maxYValuel: 0) { Done in
            self.infoView.removeFromSuperview()
        }
    }
    
    func loadInfoDetails(){

        self.infoView.scrollView.setContentOffset(.zero, animated: false)
        
        let visibleRect = CGRect(origin: collectionVw.contentOffset, size: collectionVw.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = collectionVw.indexPathForItem(at: visiblePoint)
        selectedItem = visibleIndexPath?.row ?? 0
        let imageInfo = self.imgInfoViewModel.imgData[selectedItem]
        self.infoView.lblTitle.text = imageInfo.title
        self.infoView.lblExplanation.text = imageInfo.explanation
        self.infoView.lblMediaType.text = "Media Type : " + imageInfo.mediaType
        self.infoView.lblCopyRights.text = "Copyrights : \(imageInfo.copyrights)"
        self.infoView.lblCopyRights.isHidden = false
        if imageInfo.copyrights.isEmpty
        {
            self.infoView.lblCopyRights.isHidden = true
        }

        if !imageInfo.date.isEmpty
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let convertedDate = dateFormatter.date(from: imageInfo.date)
            dateFormatter.dateFormat = "dd, MMM yyyy"
            let infoDate = dateFormatter.string(from: convertedDate!)
            
            self.infoView.lblDate.text = "Date : \(infoDate)"
        }
        else{
            self.infoView.lblDate.text = ""
        }
        
    }
}

extension GalleryImageDetailVC : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width / countCell)
        let cellHeight = cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}
