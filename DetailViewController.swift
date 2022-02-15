//
//  DetailViewController.swift
//  masterDetailTemplateXCode11
//
//  Created by R.O. Chapman on 11/18/20.
//  Copyright © 2020 R.O. Chapman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionTextField: UITextField!
    
    @IBOutlet weak var moreInfoTextField: UITextField!
    
    @IBOutlet weak var reps: UITextField!
    
    @IBOutlet weak var quoteText: UILabel!
    
    //I'm sure there's a more efficient way to do this, but I can't find many alternatives.
    
    var quoteArray = ["'Action is the foundational key to all success.' -Pablo Picasso", "'Well done is better than well said.' -Benjamin Franklin", "'What hurts today makes you stronger tomorrow.' -Jay Cutler", "'The last three or four reps is what makes the muscle grow. This area of pain divides a champion from someone who is not a champion.' -Arnold Schwarzenegger", "'All progress takes place outside the comfort zone.' -Michael John Bobak", "'The only place where success comes before work is in the dictionary.' -Vidal Sassoon", "'The clock is ticking. Are you becoming the person you want to be?' -Greg Plitt", "'Once you learn to quit, it becomes a habit.' -Vince Lombardi Junior", "'Some people want it to happen, some wish it would happen, others make it happen.' -Michael Jordan", "'Look in the mirror. That’s your competition.' -John Assaraf", "'The groundwork for all happiness is good health.' -Leigh Hunt", "'The successful warrior is the average man, with laser-like focus.' -Bruce Lee", "'You must do the thing you think you cannot do.' -Eleanor Roosevelt", "'Nothing will work unless you do.' -Maya Angelou", "'Strength does not come from physical capacity. It comes from an indomitable will.' -Gahatma Gandhi", "'Do what you have to do until you can do what you want to do.' -Oprah Winfrey", "'All great achievements require time.' -Maya Angelou", "'I train to be the best in the world on my worst day.' -Ronda Rousey", "'To enjoy the glow of good health, you must exercise.' -Gene Tunney", "'Fitness is not about being better than someone else. It’s about being better than you used to be.' -Khloe Kardashian", "'Exercise is king. Nutrition is queen. Put them together and you’ve got a kingdom.' -Jack LaLanne", "'If it doesn’t challenge you, it won’t change you.' -Fred Devito", "'The only person you are destined to become is the person you decide to be.' -Ralph Waldo Emerson", "'Put all excuses aside and remember this: YOU are capable.' -Zig Ziglar" ]
    
    var masterController: ViewController!
    
    var save = false
    
    func configureView() {
        detailDescriptionTextField.text = masterController.detail[masterController.index]["Name"]
        moreInfoTextField.text = masterController.detail[masterController.index]["Sets"]
        reps.text = masterController.detail[masterController.index]["Reps"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureView();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if(save) {
        masterController.detail[masterController.index]["Name"] = detailDescriptionTextField!.text ?? ""
            masterController.detail[masterController.index]["Sets"] = moreInfoTextField!.text ?? ""
            masterController.detail[masterController.index]["Reps"] = reps.text ?? ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let saved = UIBarButtonItem(barButtonSystemItem: .save , target: self, action: #selector(saved(_:)))
        navigationItem.rightBarButtonItem = saved
        view.backgroundColor = .systemOrange
        
        configureView()
        
        //Help with assigning a random value to a label: https://stackoverflow.com/questions/41256456/get-random-string-from-an-array
        
        let randomQuote = Int(arc4random() % UInt32(quoteArray.count))
        self.quoteText.text = "\(quoteArray[randomQuote])"
    }
    
    @objc func saved(_ sender: Any) {
        save = true
    }
    
    //Functions to dismiss keyboard when tapping outside of the keyboard.
    
    @IBAction func onTapGestureRecognized(_ sender: Any) {
        reps.resignFirstResponder()
        detailDescriptionTextField.resignFirstResponder()
        moreInfoTextField.resignFirstResponder()
    }
    
    //Allows the name keyboard to disappear after hitting return
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }

}

