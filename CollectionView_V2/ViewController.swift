//
//  ViewController.swift
//  CollectionView_V2
//
//  Created by Felipe Ignacio Zapata Riffo on 05-08-21.
//

import UIKit
import SDWebImage


// MARK: - Welcome
struct Result: Codable {
    let total, totalHits: Int
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable {
    let id: Int
    let pageURL: String
    let type: TypeEnum
    let tags: String
    let previewURL: String?
    let previewWidth, previewHeight: Int
    let webformatURL: String
    let webformatWidth, webformatHeight: Int
    let largeImageURL: String
    let imageWidth, imageHeight, imageSize, views: Int
    let downloads, collections, likes, comments: Int
    let userID: Int
    let user: String
    let userImageURL: String

    enum CodingKeys: String, CodingKey {
        case id, pageURL, type, tags, previewURL, previewWidth, previewHeight, webformatURL, webformatWidth, webformatHeight, largeImageURL, imageWidth, imageHeight, imageSize, views, downloads, collections, likes, comments
        case userID = "user_id"
        case user, userImageURL
    }
}

enum TypeEnum: String, Codable {
    case photo = "photo"
}
var data_ :[Hit] = []
class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet var collectionView:UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.width)
        layout.minimumLineSpacing = 0
        let nib = UINib(nibName: "MyCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "MyCollectionViewCell")
        fetchPhotos()
        
        // Do any additional setup after loading the view.
    }
    
    func fetchPhotos(){
       let urlString = "https://pixabay.com/api/?key=22803240-e31745f15a2395fd7c7dfbae0&q=yellow+flowers&image_type=photo&pretty=true"
       guard let url = URL(string: urlString) else {
           return
       }
       let task = URLSession.shared.dataTask(with: url) { data, _, error in
           guard let data = data, error == nil else {
               return
           }
           do{
               let jsonResult = try JSONDecoder().decode(Result.self, from: data)
               DispatchQueue.main.async {
                data_ = jsonResult.hits
                self.collectionView.reloadData()
                print(data_.count)
                for value in data_{
                    print (value.pageURL)
                }
               }
             
           }
           catch {
               print(error)
           }
       }
       task.resume()
   }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data_.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        
 
        let img =  data_
        if let dataImg = img[indexPath.row].previewURL{
        cell.imageView?.sd_setImage(with: URL(string: dataImg))
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
        

}

