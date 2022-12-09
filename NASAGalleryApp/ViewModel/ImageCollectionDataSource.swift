//
//  ImageCollectionDataSource.swift
//  NASAGalleryApp
//
//  Created by Saravana kumar on 09/12/22.
//

import Foundation
import UIKit

class ImageCollectionDataSource<Cell : UICollectionViewCell, T> : NSObject, UICollectionViewDataSource {
    
    private var cellIdentifier : String!
    private var items : [T]!
    var configCell : (Cell, T) -> () = {_,_ in }
    
    init(cellIdentifier: String, items : [T], configureCell : @escaping (Cell,T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configCell = configureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! Cell
        let item = self.items[indexPath.row]
        self.configCell(cell,item)
        return cell
    }

    
}
