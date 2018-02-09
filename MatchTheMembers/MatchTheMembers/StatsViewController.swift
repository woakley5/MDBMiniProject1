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
