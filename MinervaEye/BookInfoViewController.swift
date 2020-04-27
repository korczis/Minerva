//
//  DatabaseViewController.swift
//  MinervaEye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import UIKit

class BookInfoViewController: UIViewController {

    @IBOutlet var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        detailLabel.text = "HA"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         print("PREPAAAARE !!!")
    }
    
//    override func showDetailViewController(_ vc: UIViewController,
//    sender: Any?) {
//         print("PREPAAAARE !!!")
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("PREPAAAARE !!!")
//
////         let book = sender as! BookItem
////
////        detailLabel.text = "SO" // book.volumeInfo.title
//    }

}

