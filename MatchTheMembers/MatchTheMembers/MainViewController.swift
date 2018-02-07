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
    var time: Float = 5.0
    var timerProgressBar: UIProgressView!
    
    //Other Variables
    var members = ["Daniel Andrews", "Nikhar Arora", "Tiger Chen", "Xin Yi Chen", "Julie Deng", "Radhika Dhomse", "Kaden Dippe", "Angela Dong", "Zach Govani", "Shubham Gupta", "Suyash Gupta", "Joey Hejna", "Cody Hsieh", "Stephen Jayakar", "Aneesh Jindal", "Mohit Katyal", "Mudabbir Khan", "Akkshay Khoslaa", "Justin Kim", "Eric Kong", "Abhinav Koppu", /*"Srujay Korlakunta",*/ "Ayush Kumar", "Shiv Kushwah", "Leon Kwak", "Sahil Lamba", "Young Lin", "William Lu", "Louie McConnell", "Max Miranda", "Will Oakley", "Noah Pepper", "Samanvi Rai", "Krishnan Rajiyah", "Vidya Ravikumar", "Shreya Reddy", "Amy Shen", "Wilbur Shi", "Sumukh Shivakumar", "Fang Shuo", "Japjot Singh", "Victor Sun", "Sarah Tang", "Kanyes Thaker", "Aayush Tyagi", "Levi Walsh", "Carol Wang", "Sharie Wang", "Ethan Wong", "Natasha Wong", "Aditya Yadav", "Candice Ye", "Vineeth Yeevani", /*"Jeffery Zhang"*/]
    var score = 0
    var streak = 0
    var correctButtonNumber: Int! = -1
    var last3Answers: [String]! = []
    
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
        // Tags: 1    2
        //       3    4
        for i in 0..<4 {
            var buttonX: Int!
            var buttonY: Int!
            
            if i <= 1 { //first row of buttons
                buttonX = 15 + 175*i
                buttonY = scoreY + labelHeight + 10
            }
            else {
                buttonX = 15 + 175*(i-2)
                buttonY = scoreY + labelHeight + 80
            }
            
            let buttonWidth = 175
            
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
        
        //Timer ProgressBar Setup
        timerProgressBar = UIProgressView(frame: CGRect(x: 0, y: view.frame.height - 10, width: view.frame.width, height: 10))
        timerProgressBar.setProgress(0.0, animated: true)
        view.addSubview(timerProgressBar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        newQuestion()
    }
    
    @objc func tappedButton(sender: UIButton){
        mainTimer.invalidate()
        print("Tapped Button " + String(sender.tag))
        if sender.tag - 1 == correctButtonNumber {
            correct()
        }
        else{
            incorrect()
        }
    }
    
    func newQuestion(){
        let personNumber = Int(arc4random_uniform(UInt32(members.count))) //generates random person
        print("Person: " + members[personNumber])
        let imageName = members[personNumber].replacingOccurrences(of: " ", with: "").lowercased() //gets image name
        print(imageName)
        mainImageView.image = UIImage(named: imageName)
        
        correctButtonNumber = Int(arc4random_uniform(4)) //picks a random button to display answer
        let b = view.viewWithTag(correctButtonNumber + 1) as! UIButton // why cant I use button from optionButtons array??
        b.setTitle(members[personNumber], for: .normal)
        
        var i = 0
        while i < 4{ //fills in all other buttons with random names
            if i != correctButtonNumber{ //skip over the button that is already set
                let randomNameIndex = Int(arc4random_uniform(UInt32(members.count)))
                if randomNameIndex != personNumber { //cant display correct answer twice
                    let b = view.viewWithTag(i + 1) as! UIButton
                    b.setTitle(members[randomNameIndex], for: .normal)
                    i = i + 1
                }
                else{
                    print("Correct answer twice")
                    i = i - 1
                }
            }
            else{
                i = i + 1
            }
        }
        
        if last3Answers.count >= 3{
            last3Answers.remove(at: 0)
        }
        last3Answers.append(members[personNumber])
        
        setMainTimer()
    }
    
    func showCorrectAnswer(){
        for i in 0..<4{
            let b = view.viewWithTag(i + 1) as! UIButton
            b.isUserInteractionEnabled = false  //disables button while showing correct answer
            b.backgroundColor = .red
        }
        
        let b = view.viewWithTag(correctButtonNumber + 1) as! UIButton
        b.backgroundColor = .green
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (correctTimer) in
            for i in 0..<4{
                let b = self.view.viewWithTag(i + 1) as! UIButton
                b.backgroundColor = .yellow
            }
            for i in 0..<4{
                let b = self.view.viewWithTag(i + 1) as! UIButton
                b.isUserInteractionEnabled = true
            }
            self.newQuestion()
        }
    }
    
    func incorrect(){
        print("Incorrect!")
        streak = 0
        showCorrectAnswer()
    }
    
    func correct(){
        print("Correct!")
        streak = streak + 1
        score = score + 1
        scoreLabel.text = "Score: " + String(score)
        showCorrectAnswer()
    }
    
    func setMainTimer(){
        timerProgressBar.setProgress(1.0, animated: false)
        time = 5.0
        timerLabel.text = "Time Remaining: 5.0"
        mainTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        time = time - 0.1
        timerProgressBar.setProgress(time/5.0, animated: true)
        timerLabel.text = "Time Remaining: " + String(round(time * 10.0)/10.0)
        if time <= 0.0{
            mainTimer.invalidate()
            timerLabel.text = "Time Remaining: 0.0"
            time = 5.0
            showCorrectAnswer()
        }
    }

    @objc func showStatsScreen(){
        mainTimer.invalidate()
        self.performSegue(withIdentifier: "showStatsScreen", sender: self)
    }

}
