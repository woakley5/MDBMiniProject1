//
//  StatsViewController.swift
//  MatchTheMembers
//
//  Created by Will Oakley on 2/7/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    var last3Answers: [String]?
    var score: Int?
    var streak: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "My Stats"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(last3Answers!)
        populateLast3()
        populateScore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateScore(){
        let labelY = Int((self.navigationController?.navigationBar.frame.height)! + self.view.frame.height * 0.05)
        
        let scoreLabel = UILabel(frame: CGRect(x: 20, y: labelY, width: Int(self.view.frame.width/2 - 40), height: 60))
        scoreLabel.text = "Score: " + String(score!) + "\n"
        scoreLabel.textAlignment = .center
        scoreLabel.numberOfLines = 2
        view.addSubview(scoreLabel)
        
        let streakLabel = UILabel(frame: CGRect(x: Int(view.frame.width/2 + 20), y: labelY, width: Int(view.frame.width/2 - 40), height: 60))
        streakLabel.textAlignment = .center
        streakLabel.numberOfLines = 2
        if streak! > 0{
            streakLabel.text = "Streak: " + String(streak!) + "\n🔥🔥🔥" //gotta add those emojis 🤪
        }
        else{
            streakLabel.text = "Streak: " + String(streak!) + "\n☹️"
        }
        view.addSubview(streakLabel)
    }

    func populateLast3(){
        let populate3TitleLabel = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.25, width: view.frame.width, height: 20))
        populate3TitleLabel.text = "Recent Answers"
        populate3TitleLabel.font = UIFont.init(name: "Helvetica Bold", size: 20)
        populate3TitleLabel.textAlignment = .center
        view.addSubview(populate3TitleLabel)
        //Setting up all images and labels in this pattern:
        //  1     2
        //     3
        for (i, n) in last3Answers!.enumerated(){
            let x: Int
            let y: Int
            let width = 125
            let height = 125
            if i < 2{
                let buffer = (Int(view.frame.width/2) - width)/2
                x =  (Int(view.frame.width)/2 - buffer - width) + (i * (width + buffer * 2))
                y = 200
            }
            else{
                x =  Int(view.frame.width/2 - 125/2)
                y = 400
            }
            let imageView = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
            let imageName =  n.replacingOccurrences(of: " ", with: "").lowercased()
            imageView.image = UIImage(named: imageName)
            view.addSubview(imageView)
            
            let imageLabel = UILabel(frame: CGRect(x: x, y: y + height, width: width, height: 40))
            imageLabel.text = n
            imageLabel.textAlignment = .center
            imageLabel.numberOfLines = 2
            view.addSubview(imageLabel)
        }
    }
}
