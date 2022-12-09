//
//  ImageViewModel.swift
//  NASAGalleryApp
//
//  Created by Saravana kumar on 09/12/22.
//

import Foundation

class ImageViewModel : NSObject {
    
    private var apiService : APIService!
    private(set) var imgData : [ImageModel]! {
        didSet{
            self.imgViewModelData()
        }
    }
    
    var imgViewModelData : (() -> ()) = {}
    
    override init(){
        super.init()
        
        self.apiService = APIService()
        getImageDetails()
    }
    
    func getImageDetails(){
        
        self.apiService.apiToGetImageData { (images) in
            self.imgData = images
        }
        
    }
}
