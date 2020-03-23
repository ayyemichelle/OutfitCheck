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
        
        for (type, clothing) in suggestResult{
            if (type == "bottom"){
                if (clothing.contains("Shorts")){
                    bottomImage.image = UIImage(named: "short")
                }
                else if (clothing.contains("Skirt")){
                    bottomImage.image = UIImage(named: "skirt")
                }
                else{
                    bottomImage.image = UIImage(named: "jeans")
                }
                bottomLabel.text = clothing
            }
            
            if (type == "top"){
                if (clothing == "Sweater" || clothing.contains("Long")){
                    topImage.image = UIImage(named: "sweater")
                }
                else if (clothing.contains("Tank")){
                    topImage.image = UIImage(named: "tanktop")
                }
                else{
                    topImage.image = UIImage(named: "tshirt")
                }
                topLabel.text = clothing
            }
            
            if (type == "shoes"){
                if (clothing == "Boots"){
                    shoeImage.image = UIImage(named: "boots")
                }
                else if (clothing.contains("Flats")){
                    shoeImage.image = UIImage(named: "flats")
                }
                
                else if (clothing == "Sandals"){
                    shoeImage.image = UIImage(named: "sandals")
                }
                else{
                    shoeImage.image = UIImage(named: "shoe")
                }
                shoeLabel.text = clothing
            }
            
            if (type == "outerwear"){
                if (clothing == "Coat" || clothing == "Blazer"){
                    outerwearImage.image = UIImage(named: "blazer")
                }
                else if (clothing == "Cardigan"){
                    outerwearImage.image = UIImage(named: "cardigan")
                }
                
                else{
                    outerwearImage.image = UIImage(named: "jacket")
                }
                outwearLabel.text = clothing
            }
        }
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
