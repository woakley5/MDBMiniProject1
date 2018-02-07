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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton = UIButton(frame: CGRect(x: 50, y: 200, width: view.frame.width - 100, height: 100))
        startButton.setTitle("Start the Game!", for: .normal)
        startButton.setTitleColor(.blue, for: .normal)
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
