//
//  UIExtension.swift
//  NASAGalleryApp
//
//  Created by Saravana kumar on 09/12/22.
//

import Foundation
import UIKit


let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    func loadImageUsingCache(withURLStr : String) {
        let url = URL(string: withURLStr)
        if url == nil {return}
        self.image = nil
        
        //check cache image
        if let cacheImage = imageCache.object(forKey: withURLStr as NSString) {
            self.image = cacheImage
            return
        }
    
        let activityInd = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        addSubview(activityInd)
        activityInd.startAnimating()
        activityInd.center = self.center
        
        //if not, download
        URLSession.shared.dataTask(with: url!) { (data, urlResponse, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    if let image = UIImage(data: data)
                    {
                        imageCache.setObject(image, forKey: withURLStr as NSString)
                        self.image = image
                        activityInd.stopAnimating()
                    }
                }
            }
        }.resume()

    }
    
}

extension UIView {
    
    func viewAnimationUp(isAppear: Bool,maxYValuel : CGFloat, completion: ((Bool) -> Void)? = nil) {
        self.layoutIfNeeded()
        let animation = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 1) {
            
            if isAppear {
                self.frame.origin.y = maxYValuel
            }
            else{
                self.frame.origin.y = UIScreen.main.bounds.height
            }
        }
        animation.addCompletion { position in
            if position == .end {
                
                if !isAppear {
                    
                }
                completion?(true)
            }
        }
        animation.startAnimation()
        
    }
    
}
