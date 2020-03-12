//
//  SuggestOutfitViewController.swift
//  OutfitCheck
//
//  Created by Karla on 3/12/20.
//  Copyright © 2020 Karla. All rights reserved.
//

import UIKit

class SuggestOutfitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "BlueFiresSample", size: 19) as Any]
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
