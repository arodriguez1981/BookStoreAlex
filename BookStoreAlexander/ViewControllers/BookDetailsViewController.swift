//
//  BookDetailsViewController.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift
import SwiftFontIcons

class BookDetailsViewController: UIViewController {
    @IBOutlet var svDetails: UIScrollView!
    @IBOutlet var lblNoData: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblSubtitle: UILabel!
    @IBOutlet var lblAuthors: UILabel!
    @IBOutlet var ivThumbnail: UIImageView!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var btnBuy: UIButton!
    @IBOutlet var btnFav: UIButton!
    var workItem: DispatchWorkItem?
    var bookID: String?
    var book : Volume?
    @IBOutlet var ivStar: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.svDetails.isHidden = true
        self.lblNoData.isHidden = true
        getBookDetails()
    }
    
    private func getBookDetails() {
        workItem = DispatchWorkItem{
            NetConnection.getBookDetails(self.bookID!, response: ResponseHandler(startHandler: nil , success: { response in
                if response["error"].exists()  { // If error
                    self.svDetails.isHidden = true
                    self.lblNoData.isHidden = false
                }
                else{
                    self.book = Volume(response) // Create a book from response
                    let predicate = NSPredicate(format: "id = %@",  self.bookID!)
                    let results = realm.objects(Volume.self).filter(predicate) // Search the book in stored books
                    if results.count > 0{ // If appear
                        self.book!.fav = results.first!.fav // Set favs
                    }
                    try! realm.write {
                        realm.add(self.book!, update: .modified) // add to stored books
                    }
                    self.fillInfo() //And fill view Info
                }
                return nil
            } , failure: {(_ error: NSError, data: Data?) in
                self.svDetails.isHidden = true
                self.lblNoData.isHidden = false
            }))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() , execute: workItem!)
    }
    
    private func fillInfo() {
        // Set fav info (it´s don´t exist online) with the store book information (results.first!)
        let predicate = NSPredicate(format: "id = %@",  bookID!)
        let results = realm.objects(Volume.self).filter(predicate)
        if results.count > 0{
            if results.first!.fav == 0{
                ivStar.image = "star".fa.image(color: .gray, size:25 )
            }
            else{
                ivStar.image = "star".fa.image(color: .blue, size:25 )
            }
        }
        
        //Fill the rest of info in vc. Can use results.first! or self.book
        lblTitle.text = self.book!.volumeInfo!.title //
        lblSubtitle.text = self.book!.volumeInfo!.subtitle
        lblDescription.text = self.book!.volumeInfo!.desc
        var authors = ""
        for author in self.book!.volumeInfo!.authors{
            if authors.isEmpty {
                authors = author
            } else {
                authors += " , \(author)"
            }
        }
        lblAuthors.text = authors
        let urlImageBook = self.book!.volumeInfo?.imageLinks!.thumbnail // set the image
        if urlImageBook != nil &&  urlImageBook != ""{
            DispatchQueue.main.async(execute: {() -> Void in
                self.ivThumbnail.setImageWith(URL(string: urlImageBook!)!, placeholderImage: "book".fa.image(color: .gray, size: self.ivThumbnail.frame.size.height))
            })
        }
        else{
            ivThumbnail.image = "book".fa.image(color: .gray, size: self.ivThumbnail.frame.size.height)
        }
        if self.book!.saleInfo?.buyLink != nil && self.book!.saleInfo?.buyLink != ""{
            btnBuy.isHidden = false
            btnBuy.isUserInteractionEnabled = true
        }
        else{
            btnBuy.isHidden = true
            btnBuy.isUserInteractionEnabled = false
        }
        self.svDetails.isHidden = false
        self.lblNoData.isHidden = true
    }

    @IBAction func setFavorite(_ sender: Any) {
        // Set fav value in store book
        let predicate = NSPredicate(format: "id = %@",  bookID!)
        let results = realm.objects(Volume.self).filter(predicate)
        if results.count > 0{
            if results.first!.fav == 0{
                ivStar.image = "star".fa.image(color: .blue, size:25 )
                try! realm.write {
                    results.first!.fav = 1
                }
            }
            else{
                ivStar.image = "star".fa.image(color: .gray, size:25 )
                try! realm.write {
                    results.first!.fav = 0
                }
            }
        }
    }
    
    @IBAction func buyBook(_ sender: Any) {
        // Open external App Safari to show buy link
        if let url = URL(string: self.book!.saleInfo!.buyLink!) {
            UIApplication.shared.open(url)
        }
    }
}
