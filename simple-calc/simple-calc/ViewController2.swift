//
//  ViewController2.swift
//  simple-calc
//
//  Created by Andre Nguyen on 2/1/18.
//  Copyright © 2018 Andre Nguyen. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

        var wordBank:[String] = []
    
        @IBOutlet weak var scrollView: UIScrollView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            if wordBank.count > 0 {
                for index in 0...wordBank.count - 1 {
                    let label = UILabel(frame: CGRect(x: 50, y: index * 25 + 50, width: 300, height: 40))
                    label.text = wordBank[index]
                    view.addSubview(label)
                    scrollView.addSubview(label)
                }
            }
        }
    
    
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
            if segue.destination is ViewController {
                let talkView = segue.destination as! ViewController
                talkView.wordBank = wordBank
            }
        }
    
    
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
