//
//  StartViewController.swift
//  MatchTheMembers
//
//  Created by Will Oakley on 2/7/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    var startButton: UIButton!
    var mainImage: UIImageView!
    var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        startButton = UIButton(frame: CGRect(x: 50, y: 200, width: view.frame.width - 100, height: 100))
        startButton.setTitle("Start the Game!", for: .normal)
        startButton.setTitleColor(.blue, for: .normal)
        startButton.addTarget(self, action: #selector(showMainScreen), for: .touchUpInside)
        
        mainImage = UIImageView(frame: CGRect(x: 20, y: 30, width: view.frame.width - 40, height: 200))
        mainImage.contentMode = .scaleAspectFit
        mainImage.image = #imageLiteral(resourceName: "logo")
        view.addSubview(mainImage)
        view.addSubview(startButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func showMainScreen(){
        self.performSegue(withIdentifier: "showMainScreen", sender: self)
    }


}
