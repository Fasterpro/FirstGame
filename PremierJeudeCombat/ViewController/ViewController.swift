//
//  ViewController.swift
//  PremierJeudeCombat
//
//  Created by Martin Ménard on 2019-08-17.
//  Copyright © 2019 Martin Ménard. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var superMusic = Music() // Var import Music.swift
    var reponse = "1"

       override func viewDidLoad() {
        super.viewDidLoad()
         superMusic.musicInGame()
    }

    @IBAction func multiJoueur() {
    superMusic.themeGameMusic.stop()
    }

    @IBAction func modeSolo() {
       superMusic.themeGameMusic.stop()   // Stop Music
    }
}
