//
//  SuggestResultViewController.swift
//  OutfitCheck
//
//  Created by Alexis Lauren Vu on 3/18/20.
//  Copyright © 2020 Karla. All rights reserved.
//

import UIKit

class SuggestResultViewController: UIViewController {

    
    @IBOutlet weak var outerwearImage: UIImageView!
    @IBOutlet weak var outwearLabel: UILabel!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var bottomImage: UIImageView!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var shoeImage: UIImageView!
    @IBOutlet weak var shoeLabel: UILabel!
    
    
    @IBOutlet weak var startImage: UIImageView!
    
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var startTemp: UILabel!
    @IBOutlet weak var startConditions: UILabel!
    
    @IBOutlet weak var endImage: UIImageView!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var endTemp: UILabel!
    @IBOutlet weak var endConditions: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // these are the result dictionaries
        print(suggestResult)
        print(outfitCheckResult)
    }

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
