//
//  BooksListViewController.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import UIKit
import SwiftyJSON

class BooksListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var workItem: DispatchWorkItem?
    
    @IBOutlet var lblNoData: UILabel!
    @IBOutlet var cvBooksList: UICollectionView!
    @IBOutlet var svBookList: UIScrollView!    
    var activityIndiator : UIActivityIndicatorView?
    var booksList = Array<Volume>()
    var isLoadingBook = false
    var page = 0
    var totalItems = 0
    var favs = false
    var favButton = UIBarButtonItem()
    override func viewDidLoad() {
        super.viewDidLoad()
        favButton = UIBarButtonItem(image: "star".fa.image(color: .gray, size: 30), style: .plain, target: self, action: #selector(self.setFavs))
        navigationItem.rightBarButtonItem = favButton
        navigationItem.rightBarButtonItem?.tintColor = .gray
        // Configure Activity Indicator
        activityIndiator = UIActivityIndicatorView(frame: CGRect(x: self.view.frame.midX - 15, y: self.view.frame.height - 140, width: 30, height: 30))
        activityIndiator?.style = .white
        activityIndiator?.color = UIColor.black
        activityIndiator?.hidesWhenStopped = true
        activityIndiator?.backgroundColor = .clear
        activityIndiator?.layer.cornerRadius = 15
        self.view.addSubview(activityIndiator!)
        self.view.bringSubviewToFront(activityIndiator!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.svBookList.isHidden = true
        self.lblNoData.isHidden = true
        workItem?.cancel()
        self.booksList.removeAll(keepingCapacity: false)
        if !favs{
            // Load online books
            getBooks()
        }
        else{
            // Load store books
            getStoredBooks()
        }
    }
    
    @objc func setFavs() { // Bar button Favs selector
        workItem?.cancel()
        self.booksList.removeAll(keepingCapacity: false)
        self.page = 0
        if !favs{ // Select favs
            favs = true
            favButton.image =  "star".fa.image(color: .blue, size: 30)
            navigationItem.rightBarButtonItem?.tintColor = .blue
            getStoredBooks() // Load stored books
        }
        else{ // Select all
            favs = false
            favButton.image =  "star".fa.image(color: .gray, size: 30)
            navigationItem.rightBarButtonItem?.tintColor = .gray
            getBooks()  // Load online books
        }
        navigationItem.rightBarButtonItem = favButton        
    }

    private func getBooks() {
        workItem?.cancel()
        self.isLoadingBook = true // Cambiamos o valor da variable para indicar que estamos a fazer a leitura
        self.favButton.isEnabled = false
        workItem = DispatchWorkItem{
            let index: Int = self.page == 0 ? 0 : self.page * 16 - 1 // if page == 0 index = 0 else index = page * 16 -1
            NetConnection.getiOSDevelopmentBooks(16, startIndex: index , response: ResponseHandler(startHandler: nil , success: { response in // Load 16 books by request
                if response["error"].exists(){
                    self.svBookList.isHidden = true
                    self.lblNoData.isHidden = false
                }
                else{
                    self.totalItems = response["totalItems"].intValue  // Total books
                    for (_, subJson) : (String, JSON) in response["items"] {
                        let currentBook = Volume(subJson)  // Create a new Volume
                        self.booksList.append(currentBook) // Add to book list
                    }
                    if self.booksList.count > 0{ // If have favorite elements
                        self.svBookList.isHidden = false
                        self.lblNoData.isHidden = true
                    }
                    else{
                        self.svBookList.isHidden = true
                        self.lblNoData.isHidden = false
                    }
                    self.cvBooksList.reloadData() // Reload CollectionView with online books
                    self.isLoadingBook = false
                    self.activityIndiator?.stopAnimating()
                    self.favButton.isEnabled = true // Enable Bar Button
                }
                
                return nil
            } , failure: {(_ error: NSError, data: Data?) in
                DispatchQueue.main.async {
                    self.isLoadingBook = false
                    self.activityIndiator?.stopAnimating()
                    self.svBookList.isHidden = true
                    self.lblNoData.isHidden = false
                }
            }))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() , execute: workItem!)
    }
    
    private func getStoredBooks() { // Load local stored books
        workItem?.cancel()
        self.isLoadingBook = true // Set loadingBook to true
        self.favButton.isEnabled = false // and disable Bar Button
        workItem = DispatchWorkItem{
            let results = realm.objects(Volume.self)
            if results.count > 0{
                for book in results{
                    if book.fav == 1{ // if stored book is favorite
                        self.booksList.append(book) // Added to book list
                    }
                }
            }
            if self.booksList.count > 0{ // If have favorite elements
                self.svBookList.isHidden = false
                self.lblNoData.isHidden = true
            }
            else{
                self.svBookList.isHidden = true
                self.lblNoData.isHidden = false
            }
            self.isLoadingBook = false
            self.cvBooksList.reloadData() //Reload CollectionView with stored favs books
            self.activityIndiator?.stopAnimating()
            self.favButton.isEnabled = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() , execute: workItem!)
    }
    
    /*
     // MARK CollectionView
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return booksList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let bookCell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath ) as! BookCell
        let urlImageBook = self.booksList[indexPath.item].volumeInfo!.imageLinks!.thumbnail // Obtain the image
        if urlImageBook != nil &&  urlImageBook != ""{
            DispatchQueue.main.async(execute: {() -> Void in
                bookCell.photo.setImageWith(URL(string: urlImageBook!)!) // and set the ImageView.image
                bookCell.photo.contentMode = .scaleAspectFit
            })
        }
        else{
            bookCell.photo.image = "book".fa.image(color: .gray, size: bookCell.photo.frame.size.height)
        }
        bookCell.title.text = self.booksList[indexPath.item].volumeInfo!.title // Set title
        return bookCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                if booksList.count > 0{
                    let book = booksList[indexPath.row]
                    let vc = storyboard!.instantiateViewController(withIdentifier: "bookDetailsViewController") // Instantiate book Details
                    let controller = vc as! BookDetailsViewController
                    controller.bookID = book.id // And send the bookID
                    self.navigationController?.pushViewController(vc, animated: true)
                }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let width = (self.view.frame.size.width - 30) / 2 //2 columns by row
       
        return CGSize(width: width, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) // Cell spaces
    }
 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height

        if offsetY > contentHeight - frameHeight && !isLoadingBook && !self.favs{ // If arrive to bottom of the screen
           self.loadOthers() // Load more items
        }
    }
    
    private func loadOthers(){
        DispatchQueue.main.async(execute: {() -> Void in
            if self.booksList.count < self.totalItems{ // if are more items
                self.isLoadingBook = true
                self.activityIndiator?.startAnimating()
                self.view.bringSubviewToFront(self.activityIndiator!)
                self.page = self.page + 1 // page increment
                self.getBooks() // and load more books
            }
            else{
                self.activityIndiator?.stopAnimating()
            }
        })
    }}
