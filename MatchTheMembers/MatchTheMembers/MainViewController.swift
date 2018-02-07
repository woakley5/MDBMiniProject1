//
//  MainViewController.swift
//  MatchTheMembers
//
//  Created by Will Oakley on 2/7/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var mainImageView: UIImageView!
    var optionButtons: [UIButton]!
    var selectLabel: UILabel!
    var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //// Navigation bar settings
        self.navigationItem.title = "Match the Members!"
        
        /// Button for stats screen
        let statsButton = UIButton(type: UIButtonType.infoDark)
        statsButton.addTarget(self, action: #selector(showStatsScreen), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: statsButton)
        
        //Image View Setup
        let imgX = 30
        let imgY = 90
        let imgDimension = Int(self.view.frame.width) - (imgX * 2)
        mainImageView = UIImageView(frame: CGRect(x: imgX, y: imgY, width: imgDimension, height: imgDimension))
        mainImageView.contentMode = .scaleAspectFit
        mainImageView.image = #imageLiteral(resourceName: "willoakley")
        view.addSubview(mainImageView)
        
        //Score Label Setup
        let scoreX = 50
        let scoreY = imgY + imgDimension + 20
        let labelWidth = Int(self.view.frame.width) - (scoreX * 2)
        let labelHeight = 30
        scoreLabel = UILabel(frame: CGRect(x: scoreX, y: scoreY, width: labelWidth, height: labelHeight))
        scoreLabel.textAlignment = .center
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        //Button Setup
        //  1    2
        //  3    4
        for i in 0..<4 {
            var buttonX: Int!
            var buttonY: Int!
            
            if i <= 1 { //first row of buttons
                buttonX = 50 + 200*i
                buttonY = scoreY + labelHeight + 50
            }
            else {
                buttonX = 50 + 200*(i-2)
                buttonY = scoreY + labelHeight + 150
            }
            
            let buttonWidth = 100
            
            let b = UIButton(frame: CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: 50))
            b.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
            b.setTitle("Name " + String(i), for: .normal)
            b.setTitleColor(.blue, for: .normal)
            b.backgroundColor = .yellow
            b.tag = i
            view.addSubview(b)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tappedButton(sender: UIButton){
        print("Tapped Button " + String(sender.tag))
    }
    
    func newImage(){
        
    }
    

    @objc func showStatsScreen(){
        self.performSegue(withIdentifier: "showStatsScreen", sender: self)
    }

}
