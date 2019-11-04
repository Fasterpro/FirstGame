//
//  SoloViewController.swift
//  Jeu De Combat
//
//  Created by Martin Ménard on 2019-09-05.
//  Copyright © 2019 Martin Ménard. All rights reserved.
//

import UIKit

class SoloViewController: UIViewController {

    @IBOutlet weak var labelpro: UILabel!
    
    @IBOutlet weak var stackviewrotationpts: UIStackView!

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
           
        }
        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
                         super.viewWillTransition(to: size, with: coordinator)
                         if UIDevice.current.orientation.isLandscape {
                             print("Landscape")
                            stackviewrotationpts.transform = CGAffineTransform(rotationAngle: -90)
                          }
                      else {
                    
                       
                         
                
                         }
}
    }








        /*

        testtimelabel.isHidden = false
        esquiverestant.isHidden = false
        pausebutton.isHidden = true
        esquivebutton.isHidden = true
        
    }*/
        




 //imageViewtest.isHidden = true
    /*

    @IBOutlet weak var startbutton: UIButton!
    @IBOutlet weak var pausebutton: UIButton!
    @IBOutlet weak var esquivebutton: UIButton!
    

    @IBOutlet weak var boutonatteint: UIButton!
    
    var Timetest: Timer?
    var GameTimeCountdown: Float = 100.0
    
    var PlayouPause = true //(false = pause ... true = play )
    var EsquiveOn = false
    
    var Esquivetest2: Timer?
    var esquivecountdown: Float = 2.0
    
    @IBOutlet weak var testtimelabel: UILabel!
    @IBOutlet weak var esquiverestant: UILabel!
    
    @objc private func TimerFunc() { // Start function for time
        GameTimeCountdown -= 0.1 // TIMER NORMAL.. !!!
        testtimelabel.text = ("\(GameTimeCountdown) sec") as String
     }
    
    func TimeOpenApps() {
        Timetest = Timer.scheduledTimer(timeInterval: 0.1, target: self,  // to stop time
        selector: #selector(TimerFunc), userInfo: nil, repeats: true)
    }
    
    @objc private func EsquiveFunc() {
        esquivecountdown -= 0.1
        esquiverestant.text = ("\(esquivecountdown) sec") as String
        if esquivecountdown <= 0 {
            boutonatteint.isEnabled = true
            esquiverestant.text = ("0")
            Esquivetest2?.invalidate()
            esquivecountdown = 2.0
            EsquiveOn = false
            esquivebutton.isEnabled = true
            
        }
        else {
        }
     }
    
    func TimeEsquivetime() {
        Esquivetest2 = Timer.scheduledTimer(timeInterval: 0.1, target: self,
        selector: #selector(EsquiveFunc), userInfo: nil, repeats: true)
    }
    
    @IBAction func StarGame() {
        TimeOpenApps()
        pausebutton.isHidden = false
        esquivebutton.isHidden = false
    }
    
    
    
    
    
    @IBAction func Pause() {
   
        if PlayouPause == true {
            pausebutton.setTitle("To go Play", for: .normal)
            Timetest?.invalidate()
            PlayouPause = false
            
            if EsquiveOn == true {
                esquivebutton.isEnabled = false
                Esquivetest2?.invalidate()
            }
                
            else {
            }
        }
        else {
             pausebutton.setTitle("To Go pause", for: .normal)
                TimeOpenApps()
            PlayouPause = true
            if EsquiveOn == true {
                 TimeEsquivetime()
                 }
             else {
                 }
        }
}
    
    @IBAction func Esquivetest() {
        EsquiveOn = true
        esquivebutton.isEnabled = false
        boutonatteint.isEnabled = false
        TimeEsquivetime()
    }
    */
