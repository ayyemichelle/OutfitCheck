//
//  OutfitCheckResultViewController.swift
//  OutfitCheck
//
//  Created by Lynette Nguyen on 3/22/20.
//  Copyright © 2020 Karla. All rights reserved.
//

import UIKit

class OutfitCheckResultViewController: UIViewController {

    
    @IBOutlet weak var outfitImage: UIImageView!
    @IBOutlet weak var suggestImage: UIImageView!
    @IBOutlet weak var suggestLabel: UILabel!
    
    
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
