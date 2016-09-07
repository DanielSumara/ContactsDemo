//
//  ImageManager.swift
//  ContactList
//
//  Created by Daniel Sumara on 07.09.2016.
//  Copyright © 2016 Sumara. All rights reserved.
//

import UIKit

protocol ImageRepositoryProtocol {
    
    func getImageFrom(url: String, completionBlock: ServiceResult<(String, UIImage)> -> Void)
    
}

class ImageRepository: ImageRepositoryProtocol {
    
    // MARK: - Helping content
    
    private enum UserDefaultsKeys: String {
        case ImagesSavedOnDevice
    }
    
    // MARK: - Properties
    
    private let errorUtils: ErrorUtils
    
    /// Key - Image url
    /// Value:
    ///     = nil - indicate loading is in progress
    ///     = some - image is downloaded
    /// Lack of key means we have no image on device
    private var cache: [String: Image] = [:]
    
    /// List of images stored on device
    private var imagesSavedOnDevice: [String] = [] {
        didSet {
            saveDownloadedUrlsInNSUserDafaults()
        }
    }
    
    private let documentsPath = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first
    
    // MARK: - Lifecicle
    
    init(errorUtils: ErrorUtils) {
        self.errorUtils = errorUtils
        restoreDownloadedUrlsFromNSUserDefaults()
    }
    
    // MARK: - API
    
    func getImageFrom(url: String, completionBlock: ServiceResult<(String, UIImage)> -> Void) {
        if let imageFromCache = self.cache[url] {
            if (imageFromCache.isInMemory) {
                if let image = imageFromCache.image {
                    completionBlock(.Success(url, image))
                }
                else {
                    getImageFromMemory(imageFromCache, completionBlock: completionBlock)
                }
            }
            else if (imageFromCache.isDownloading) {
                delay(Constants.Time.CheckDownloadStatusInterval) { [weak self] in
                    self?.getImageFrom(url, completionBlock: completionBlock)
                }
            }
        }
        else {
            let image = Image(url: url)
            self.cache[url] = image
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { [weak self] in
                guard let urlToImage = NSURL(string: url) else {
                    self?.failure(completionBlock, withError: self?.errorUtils.getBadUrlError())
                    return
                }
                guard let data = NSData(contentsOfURL: urlToImage) else {
                    self?.failure(completionBlock, withError: self?.errorUtils.getInvalidDataFromNetworkError())
                    return
                }
                
                self?.saveImageInMemory(image, imageData: data)
                
                guard let image = UIImage(data: data) else {
                    self?.failure(completionBlock, withError: self?.errorUtils.getInvalidDataFromNetworkError())
                    return
                }
                let updatedImage = Image(url: url, image: image)
                self?.cache[url] = updatedImage
                dispatch_async(dispatch_get_main_queue()) {
                    completionBlock(.Success(url, image))
                }
            }
        }
    }
    
    // MARK: - Methods
    
    private func saveDownloadedUrlsInNSUserDafaults() {
        NSUserDefaults.standardUserDefaults().setObject(self.imagesSavedOnDevice, forKey: UserDefaultsKeys.ImagesSavedOnDevice.rawValue)
    }
    
    private func restoreDownloadedUrlsFromNSUserDefaults() {
        if let savedUrls = NSUserDefaults.standardUserDefaults().objectForKey(UserDefaultsKeys.ImagesSavedOnDevice.rawValue) as? [String] {
            self.imagesSavedOnDevice = savedUrls
            for url in savedUrls {
                self.cache[url] = Image(urlFromMemory: url)
            }
        }
    }
    
    private func failure(completionBlock: ServiceResult<(String, UIImage)> -> Void, withError error: NSError?) {
        if let error = error {
            completionBlock(.Failure(error))
        }
    }
    
    private func getImageFromMemory(image: Image, completionBlock: ServiceResult<(String, UIImage)> -> Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { [weak self] in
            guard let documentsPath = self?.documentsPath else { return }
            let imagePath = documentsPath.URLByAppendingPathComponent(self?.convertUrlToFileName(image.imageUrl) ?? "unnown")
            guard let imageFromMemory = UIImage(contentsOfFile: imagePath.relativePath!) else {
                if let errorUtils = self?.errorUtils {
                    // TODO: Completion block can never execute if ImageManager will be released
                    completionBlock(.Failure(errorUtils.getInvalidImageInMemoryError()))
                }
                return
            }
            let updatedImage = Image(url: image.imageUrl, image: imageFromMemory)
            self?.cache[image.imageUrl] = updatedImage
            dispatch_async(dispatch_get_main_queue()) {
                completionBlock(.Success(updatedImage.imageUrl, imageFromMemory))
            }
        }
    }
    
    private func saveImageInMemory(image: Image, imageData: NSData) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { [weak self] in
            guard let documentsPath = self?.documentsPath else { return }
            let imagePath = documentsPath.URLByAppendingPathComponent(self?.convertUrlToFileName(image.imageUrl) ?? "unnown")
            
            imageData.writeToFile(imagePath.relativePath!, atomically: true)
            
            let updatedImage = Image(urlFromMemory: image.imageUrl)
            self?.imagesSavedOnDevice.append(updatedImage.imageUrl)
            self?.cache[updatedImage.imageUrl] = updatedImage
        }
    }
    
    private func convertUrlToFileName(url: String) -> String {
        var fileName = url
        fileName = fileName.stringByReplacingOccurrencesOfString("https://", withString: "")
        fileName = fileName.stringByReplacingOccurrencesOfString("http://", withString: "")
        fileName = fileName.stringByReplacingOccurrencesOfString("/", withString: "-")
        
        return fileName
    }
    
    // TODO: - DRY
    private func delay(delay: Double, closure: () -> Void) {
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue(), closure)
    }
    
}
