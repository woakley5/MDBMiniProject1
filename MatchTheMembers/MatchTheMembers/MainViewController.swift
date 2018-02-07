//
//  MainViewController.swift
//  MatchTheMembers
//
//  Created by Will Oakley on 2/7/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //UI Objects
    var mainImageView: UIImageView!
    var optionButtons: [UIButton]!  //not working but want to ask about it
    var selectLabel: UILabel!
    var scoreLabel: UILabel!
    var timerLabel: UILabel!
    
    //Timers
    var mainTimer: Timer!
    var showCorrectTimer: Timer!
    
    //Other Variables
    var members = ["Daniel Andrews", "Nikhar Arora", "Tiger Chen", "Xin Yi Chen", "Julie Deng", "Radhika Dhomse", "Kaden Dippe", "Angela Dong", "Zach Govani", "Shubham Gupta", "Suyash Gupta", "Joey Hejna", "Cody Hsieh", "Stephen Jayakar", "Aneesh Jindal", "Mohit Katyal", "Mudabbir Khan", "Akkshay Khoslaa", "Justin Kim", "Eric Kong", "Abhinav Koppu", /*"Srujay Korlakunta",*/ "Ayush Kumar", "Shiv Kushwah", "Leon Kwak", "Sahil Lamba", "Young Lin", "William Lu", "Louie McConnell", "Max Miranda", "Will Oakley", "Noah Pepper", "Samanvi Rai", "Krishnan Rajiyah", "Vidya Ravikumar", "Shreya Reddy", "Amy Shen", "Wilbur Shi", "Sumukh Shivakumar", "Fang Shuo", "Japjot Singh", "Victor Sun", "Sarah Tang", "Kanyes Thaker", "Aayush Tyagi", "Levi Walsh", "Carol Wang", "Sharie Wang", "Ethan Wong", "Natasha Wong", "Aditya Yadav", "Candice Ye", "Vineeth Yeevani", /*"Jeffery Zhang"*/]
    var score = 0
    var correctButtonNumber: Int! = -1
    
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
        // Tags: 0    1
        //       2    3
        for i in 0..<4 {
            var buttonX: Int!
            var buttonY: Int!
            
            if i <= 1 { //first row of buttons
                buttonX = 40 + 150*i
                buttonY = scoreY + labelHeight + 10
            }
            else {
                buttonX = 40 + 150*(i-2)
                buttonY = scoreY + labelHeight + 80
            }
            
            let buttonWidth = 200
            
            let b = UIButton(frame: CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: 50))
            b.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
            b.setTitle("Name " + String(i), for: .normal)
            b.setTitleColor(.blue, for: .normal)
            b.backgroundColor = .yellow
            b.tag = i + 1 //plus one because all views have default of 0
            view.addSubview(b)
        }
        
        //Timer Label Setup
        let timerX = 50
        let timerY = Int(view.frame.height) - 75
        let timerWidth = Int(view.frame.width) - (timerX * 2)
        timerLabel = UILabel(frame: CGRect(x: timerX, y: timerY, width: timerWidth, height: 50))
        timerLabel.textAlignment = .center
        timerLabel.text = "Time Remaining: " + "5.0"
        view.addSubview(timerLabel)
        
        newQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tappedButton(sender: UIButton){
        print("Tapped Button " + String(sender.tag))
        newQuestion()
    }
    
    func newQuestion(){
        let personNumber = Int(arc4random_uniform(UInt32(members.count)))
        print("Person: " + members[personNumber])
        let imageName = members[personNumber].replacingOccurrences(of: " ", with: "").lowercased()
        print(imageName)
        mainImageView.image = UIImage(named: imageName)
        
        correctButtonNumber = Int(arc4random_uniform(4))
        print("CBN: " + String(correctButtonNumber))
        let b = view.viewWithTag(correctButtonNumber + 1) as! UIButton // why cant I use button from optionButtons array??
        b.setTitle(members[personNumber], for: .normal)
        
        var i = 0
        while i < 4{
            if i != correctButtonNumber{ //skip over the button that is already set
                let randomNameIndex = Int(arc4random_uniform(UInt32(members.count)))
                if randomNameIndex == personNumber { //cant display correct answer twice
                    print("Correct answer twice")
                    i = i - 1
                }
                else{
                    print("While i: " + String(i))
                    let b = view.viewWithTag(i + 1) as! UIButton
                    b.setTitle(members[randomNameIndex], for: .normal)
                    i = i + 1
                }
            }
            else{
                i = i + 1
            }
        }
    }
    
    func incorrect(){
        
    }
    
    func correct(){
        
    }

    @objc func showStatsScreen(){
        self.performSegue(withIdentifier: "showStatsScreen", sender: self)
    }

}
