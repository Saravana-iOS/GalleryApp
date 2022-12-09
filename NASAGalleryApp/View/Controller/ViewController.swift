//
//  ViewController.swift
//  NASAGalleryApp
//
//  Created by Saravana kumar on 07/12/22.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    private var imgViewModel : ImageViewModel!
    
    let lblHeader : UILabel = {
        let lable = UILabel()
        lable.backgroundColor = .clear
        lable.font = UIFont.systemFont(ofSize: 16)
        return lable
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 0
        layout.sectionInset.left = 2
        layout.sectionInset.right = 2
        let colVw = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colVw.backgroundColor = .white
        return colVw
    }()
    
    var offSetValue : CGFloat = 2.0
    var countCell : CGFloat = 3.0

    private var dataSource : ImageCollectionDataSource<ImageCell,ImageModel>!
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUpUI()
        self.getImageDetailsFromVM()
    }
    
    func setUpUI(){
        let collectionOffSet : CGFloat = 10
        
        lblHeader.frame = CGRect(x: 0, y: 40, width: self.view.bounds.width, height: 50)
        self.view.addSubview(lblHeader)
        self.lblHeader.text = "Welcome to NASA Gallery"
        self.lblHeader.textAlignment = .center
        self.lblHeader.font = .boldSystemFont(ofSize: 17)
        let collectionHeight = self.view.bounds.height - (lblHeader.frame.maxY + collectionOffSet)
        collectionView.frame = CGRect(x: collectionOffSet, y: lblHeader.frame.maxY + collectionOffSet, width: self.view.bounds.width - (collectionOffSet*2), height: collectionHeight)
        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
    }
    
    func getImageDetailsFromVM(){
        
        self.imgViewModel = ImageViewModel()
        self.imgViewModel.imgViewModelData = {
            self.updateCollectionUI()
        }
    }
    
    func updateCollectionUI(){
        self.dataSource = ImageCollectionDataSource(cellIdentifier: "ImageCell", items: self.imgViewModel.imgData, configureCell: { (cell, imgData) in
            
            cell.galleryImage.loadImageUsingCache(withURLStr: imgData.url)
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
        })
        
        DispatchQueue.main.async {
            self.collectionView.dataSource = self.dataSource
            self.collectionView.reloadData()
        }
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth = (collectionView.frame.width / countCell)
        let spacing = (countCell + 1) * offSetValue / countCell
        let cellHeight = cellWidth - (offSetValue*2)
        cellWidth = cellWidth - spacing
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let viewModel = ImageViewModel(viewModel: self.imgViewModel.imgData)
        let imageDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GalleryImageDetailVC") as! GalleryImageDetailVC
        imageDetailVC.imgInfoViewModel = viewModel
        imageDetailVC.selectedItem = indexPath.row
        self.navigationController?.pushViewController(imageDetailVC, animated: true)
        
    }
}
