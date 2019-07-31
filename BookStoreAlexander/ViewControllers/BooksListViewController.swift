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
    @IBOutlet var cvBooksList: UICollectionView!
    var activityIndiator : UIActivityIndicatorView?
    var booksList = Array<Volume>()
    var isLoadingBook = false
    var page = 1
    var totalItems = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configurando Activity Indicator
        activityIndiator = UIActivityIndicatorView(frame: CGRect(x: self.view.frame.midX - 15, y: self.view.frame.height - 140, width: 30, height: 30))
        activityIndiator?.style = .white
        activityIndiator?.color = UIColor.black
        activityIndiator?.hidesWhenStopped = true
        activityIndiator?.backgroundColor = .clear
        activityIndiator?.layer.cornerRadius = 15
        self.view.addSubview(activityIndiator!)
        self.view.bringSubviewToFront(activityIndiator!)
        
        // Cargando libros
        getBooks(0)
    }

    private func getBooks(_ currentPage: Int) {
        self.isLoadingBook = true // Cambiamos o valor da variable para indicar que estamos a fazer a leitura
        workItem = DispatchWorkItem{
            let index: Int = currentPage == 0 ? 0 : currentPage * 15 - 1
            NetConnection.getiOSDevelopmentBooks(15, startIndex: index , response: ResponseHandler(startHandler: nil , success: { response in
                if response["error"] == nil{
                    // Manejar error
                }
                else{
                    self.totalItems = response["totalItems"].intValue  // Total de libros
                    var currentBooks = Array<Volume>()
                    for (_, subJson) : (String, JSON) in response["items"] { // Iteramos por los libros de la respuesta del request
                        let currentBook = Volume(subJson)  // Creamos un nuevo Volume
                        currentBooks.append(currentBook) // Y lo agregamos en los listados, el actual y el global
                        self.booksList.append(currentBook)
                    }
                    self.cvBooksList.reloadData() //recargamos el CollectionView
                    self.isLoadingBook = false
                    self.activityIndiator?.stopAnimating()
                }
                return nil
            } , failure: {(_ error: NSError, data: Data?) in
                DispatchQueue.main.async {
                    self.isLoadingBook = false
                    self.activityIndiator?.stopAnimating()
                }
            }))
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
        let urlImageBook = self.booksList[indexPath.item].volumeInfo?.imageLinks!.thumbnail // Obtenemos la imagen
        if urlImageBook != nil &&  urlImageBook != ""{
            DispatchQueue.main.async(execute: {() -> Void in
                bookCell.photo.setImageWith(URL(string: urlImageBook!)!, placeholderImage: UIImage(named:"book")) // Y se la asignamos al ImageView
            })
        }
        else{
            bookCell.photo.image = UIImage(named:"book")
        }
        bookCell.title.text = self.booksList[indexPath.item].volumeInfo!.title // Asignamos el titulo
        return bookCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 30) / 2 //dos libros por columna
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) // Espacio entre celdas
    }
 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height

        if offsetY > contentHeight - frameHeight && !isLoadingBook{ // Si llego a la parte baja del Scroll
            if booksList.count < totalItems{ // y aun la cantidad de libros que he cargado es menos que el total
                isLoadingBook = false
                activityIndiator?.startAnimating()
                self.view.bringSubviewToFront(activityIndiator!)
                page = page + 1 // incremento la pagina
                self.getBooks(page) // y cargo más libros
            }
        }
    }
}
