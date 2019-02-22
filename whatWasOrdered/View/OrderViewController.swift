//
//  OrderViewController.swift
//  whatWasOrdered
//
//  Created by Yevhenii Orenchuk on 2/21/19.
//  Copyright © 2019 Yevhenii Orenchuk. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {

    // MARK: Properties
    
    var username: String?
    
    // MARK: Outlets
    
    @IBOutlet weak var salatLabel: UILabel!
    @IBOutlet weak var soupLabel: UILabel!
    @IBOutlet weak var mainDishLabel: UILabel!
    @IBOutlet weak var sideDishLabel: UILabel!
    
    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
