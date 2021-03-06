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
        
        mainImage = UIImageView(frame: CGRect(x: 20, y: 30, width: view.frame.width - 40, height: 200))
        mainImage.contentMode = .scaleAspectFit
        mainImage.image = #imageLiteral(resourceName: "logo")
        view.addSubview(mainImage)

        titleLabel = UILabel(frame: CGRect(x: 20, y: 150, width: view.frame.width - 40, height: 350))
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Helvetica Bold", size: 60.0)
        titleLabel.textColor = .white
        titleLabel.text = "Match the Members!"
        view.addSubview(titleLabel)
        
        startButton = UIButton(frame: CGRect(x: 50, y: 450, width: view.frame.width - 100, height: 75))
        startButton.setTitle("Start the Game!", for: .normal)
        startButton.titleLabel?.font = UIFont.init(name: "Helvetica Bold", size: 24.0)
        startButton.setTitleColor(#colorLiteral(red: 1, green: 0.9550089813, blue: 0, alpha: 1), for: .normal)
        startButton.layer.borderColor = UIColor.white.cgColor
        startButton.layer.borderWidth = 5
        startButton.layer.cornerRadius = 10
        startButton.addTarget(self, action: #selector(showMainScreen), for: .touchUpInside)
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
