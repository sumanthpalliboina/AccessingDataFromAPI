//
//  ViewController.swift
//  AccessingDataFromAPI
//
//  Created by Palliboina on 05/05/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundle = Bundle.main
        let url = bundle.url(forResource: "book", withExtension: "json")
        let jsonData = FileManager.default.contents(atPath: url!.path)
        
        let decoder = JSONDecoder()
        
        do{
            let book = try decoder.decode(Book.self, from: jsonData!)
            print("Title is \(book.title) and Author is \(book.author)")
        }catch{
            print("Error: \(error)")
        }
        
    }


}

