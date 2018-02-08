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
        let scoreLabel = UILabel(frame: CGRect(x: 50, y: 80, width: view.frame.width - 100, height: 20))
        scoreLabel.text = "Score: " + String(score!)
        view.addSubview(scoreLabel)
        
        let streakLabel = UILabel(frame: CGRect(x: 50, y: 150, width: view.frame.width - 100, height: 20))
        if streak! > 0{
            streakLabel.text = "Streak: " + String(streak!) + "  🔥🔥🔥" //gotta add those emojis 🤪
        }
        else{
            streakLabel.text = "Streak: " + String(streak!) + " ☹️"
        }
        view.addSubview(streakLabel)
    }

    func populateLast3(){
        for (i, n) in last3Answers!.enumerated(){
            let imageView = UIImageView(frame: CGRect(x: 50, y: 200 + i * 150, width: 125, height: 125))
            let imageName =  n.replacingOccurrences(of: " ", with: "").lowercased()
            imageView.image = UIImage(named: imageName)
            view.addSubview(imageView)
            
            let imageLabel = UILabel(frame: CGRect(x: imageView.frame.minX + imageView.frame.width + 20, y: imageView.frame.minY + imageView.frame.height/2 - 10, width: 200, height: 20))
            imageLabel.text = n
            view.addSubview(imageLabel)
        }
    }

}
