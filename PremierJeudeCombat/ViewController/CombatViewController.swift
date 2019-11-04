// MARK: MARK GAME
//  CombatViewController.swift
//  PremierJeudeCombat
//
//  Created by Martin Ménard on 2019-08-17.
//  Copyright © 2019 Martin Ménard. All rights reserved.
//
// 1. OCTOBRE REFAIRE TOUS LES COURS DE A à Z

// 2.Cours sur la structure d'un code, Class MAJUSCULE
// var Majuscule2iemeMot,2.only English,.nettoyer le code. REFACTOR,4.Respect Maj and class and Min...
// BIG STRUCTURE off code

// 3.FOND dans reglage et fond dans statistiques et refaire les fonds de terrain plus pixelisé
//
// 4.ajouter statistiques toute les clic d'une game et update plus rapproche J1 J2... 0 u
//n a coté de l'autre + nb diviser partie
// % all Clic attack,esquive,regeneration
// temps en sec + min

// 7.Ajouter des SON!!!!!! 3 2 1 Go et composer de la vrai musique
//8. Jeux totalement en anglais et traduction Francais

// 9.Timer other side.. ou rotation..

// 10.message error Pop Only if the game is in progress!! not if the game is finish
// 11.if game in progress and change name.. (abandon + 1 ) if the game run...

// WORK ROTATION landscape IN STATS- OPTION AND GAME BIG PIECE!
// 12. COUNTDOWN 2 choices animation in option menu
// 13.save data
// 14.mode 1 joueur .. complete game.. thinking

// MARK: - IMPORT

    import UIKit
    import AVFoundation

// MARK: COMBAT VIEWCONTROLLER

class CombatViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

     // MARK: - VARIABLE CLASS

     var superMusic = Music()
     var stats = Statistic()
     var game = Game()
     var timerInGame: Timer?
     var timePlayedGame: Timer?
     var timertot: Timer?
     var avoidTimerP1: Timer?
     var avoidTimerP2: Timer?
     var personnagePro = Logoimage()
     var musicplaycharacter = true
     var musicstats = true
     var gotoNewGame = false

    // MARK: - INTERFACE

    func textSize() {
        energyP1Label.font = energyP1Label.font.withSize(30)
        energyP2Label.font = energyP2Label.font.withSize(30)
    }
    func textSize2() {
        energyP1Label.font = energyP1Label.font.withSize(25)
        energyP2Label.font = energyP2Label.font.withSize(25)
    }

    func alertee() {
        let alert = UIAlertController(title: "Avertissement",
            message: "Êtes-vous sur de vouloir quitter la partie en cours? Toutes progression seront perdus",
            preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                  self.superMusic.charactersMenuMusic()
                    self.stopTimeTotalandGame()
                    self.superMusic.statsMenuMusic.stop()
                     //stop stats sound
                    self.viewOption.isHidden = false
                    self.statisticMenuPro.isHidden = true
                    self.viewGame.isHidden = true
                }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { _ in
           }))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - KEYBOARD FUNC

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    var keyboard2 = true
    private func configureKeyboard() {
        player1TextField.delegate = self
        player2TextField.delegate = self
    }

    // MARK: CLAVIER FUNC

    var nameReponsePlayer1 = "test"
    var nameReponsePlayer2 = "test"
    @IBOutlet weak var player1TextField: UITextField!
    @IBOutlet weak var player2TextField: UITextField!
    @IBOutlet weak var infoPlayer1: UILabel!
    @IBOutlet weak var infoPlayer2: UILabel!

     // CLAVIER
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        player1TextField.resignFirstResponder()
        player2TextField.resignFirstResponder()
    }

    func clavierTuning() {
        let player2Answer = player2TextField.text!
        let player1Answer = player1TextField.text!

        if player1Answer == "" && player2Answer == "" {
            player1TextField.text = "Joueur 1"
            player2TextField.text = "Joueur 2"
        } else {
            nameReponsePlayer1 = player1Answer
            nameReponsePlayer2 = player2Answer
            infoPlayer1.text = ("\(player1Answer)"); print("\(player1Answer)")
            infoPlayer2.text = ("\(player2Answer)"); print("\(player2Answer)")

        // Save New Name
            UserDefaults.standard.set(player1Answer, forKey: "Player1Answer")
            UserDefaults.standard.set(player2Answer, forKey: "Player2Answer")
        }
    }

    // MARK: - UILabel Jeu
       // MARK: VIEW

    @IBOutlet weak var pauseView: UIView!
    @IBOutlet weak var viewGame: UIView!
    @IBOutlet weak var statisticMenuPro: UIView!
    @IBOutlet weak var viewOption: UIView!
    @IBOutlet weak var reglageOption: UIView!

    //Player 1 Label
    @IBOutlet weak var energyP1Label: UILabel!
    @IBOutlet weak var attackP1Label: UIButton!
    @IBOutlet weak var esquiveJ1: UIButton!
    @IBOutlet weak var regenerationJ1: UIButton!
    @IBOutlet weak var energie1F2: UILabel!
    @IBOutlet weak var energyP1Diff: UILabel!

    //Player 1 Label
    @IBOutlet weak var energyP2Label: UILabel!
    @IBOutlet weak var attackP2Label: UIButton!
    @IBOutlet weak var esquiveJ2: UIButton!
    @IBOutlet weak var regenerationJ2: UIButton!
    @IBOutlet weak var energie2F1: UILabel!
    @IBOutlet weak var energyP2Diff: UILabel!

    // MARK: - VIEW DID LOAD

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        if musicplaycharacter == true {
            superMusic.charactersMenuMusic()
            musicplaycharacter = false
        } else {
        }
        game.pauseGame = false
        viewGame.isHidden = true
        reglageOption.isHidden = true
        pause2.isHidden = true
        pauseView.isHidden = true
        configureKeyboard()
        rotationPlayer2()
        timeOpenApps()
        statisticMenuPro.isHidden = true
        viewCountdown.isHidden = true
        // Reload Save Data AT NOT WORKING
        let player1Answer = UserDefaults.standard.object(forKey: "Joueur 1") as? String
        infoPlayer1.text = player1Answer
        let player2Answer = UserDefaults.standard.object(forKey: "Joueur 2") as? String
        infoPlayer2.text = player2Answer
        let playedGameRecord = UserDefaults.standard.object(forKey: "PJR") as? String
        numbergamePlayLabel.text = playedGameRecord
        let tieGameRecord = UserDefaults.standard.object(forKey: "PNR") as? String
        numberTieGameLabel.text = tieGameRecord
        let winP1Record = UserDefaults.standard.object(forKey: "VJ1R") as? String
        numberVictoryP1Label.text = winP1Record
        let winP2Record = UserDefaults.standard.object(forKey: "VJ2R") as? String
        numberVictoryP2Label.text = winP2Record
    }

    // MARK: - MENU VIEW
    // Outlet
    var p1Choice = charactersP1
    var p2Choice = charactersP2
    @IBOutlet weak var imageCharactersP2: UIImageView!
    @IBOutlet weak var imageCharactersP1: UIImageView!
    @IBOutlet weak var characterP1PickerView: UIPickerView!
    @IBOutlet weak var characterP2PickerView: UIPickerView!
    @IBOutlet weak var p1Personage: UILabel!
    @IBOutlet weak var p2Personnage: UILabel!
    @IBOutlet weak var nameCharactersP1: UILabel!
    @IBOutlet weak var nameCharactersP2: UILabel!

// MARK: PICKER CHARACTERS

    @IBOutlet weak var imageP1: UIImageView!
    @IBOutlet weak var imageP2: UIImageView!

    var imagepro1 = UIImage(named: "Cheval")
    var imagepro2 = UIImage(named: "Chevreuil")

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return charactersP1.count
        } else {
            return charactersP2.count
        }
    }

    func imagepickerP1() {
        imageP1.image = imagepro1
        imageCharactersP1.image = imagepro1
    }

    func imagepickerP2() {
        imageP2.image = imagepro2
        imageCharactersP2.image = imagepro2
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component : Int) {
        if pickerView.tag == 1 {
            p1Personage.text = charactersP1[row]
            let p1Result = characterP1PickerView.selectedRow(inComponent: 0)
            let p1p = charactersP1[p1Result]
            personnagePro.p1Person = p1p
               if personnagePro.p1Person == "Cheval"{
                imagepro1 = #imageLiteral(resourceName: "cheval1")
                imagepickerP1()
               } else if personnagePro.p1Person == "Chevreuil"{
                    imagepro1 = #imageLiteral(resourceName: "chevreuil2")
                    imagepickerP1()
               } else if personnagePro.p1Person == "Lapin"{
                    imagepro1 = #imageLiteral(resourceName: "lapin3")
                    imagepickerP1()
               } else if personnagePro.p1Person == "Chat"{
                    imagepro1 = #imageLiteral(resourceName: "chat4")
                    imagepickerP1()
               } else if personnagePro.p1Person == "Panda" {
                    imagepro1 = #imageLiteral(resourceName: "panda5")
                    imagepickerP1()
               } else if personnagePro.p1Person == "Zèbre"{
                    imagepro1 = #imageLiteral(resourceName: "zebre6")
                    imagepickerP1()
               }
        } else {
                p2Personnage.text = charactersP2[row]
                let p2Result = characterP2PickerView.selectedRow(inComponent: 0)
                let p2p = charactersP2[p2Result]
                personnagePro.p2Person = p2p
            if personnagePro.p2Person == "Cheval"{
                imagepro2 = #imageLiteral(resourceName: "cheval1")
                imagepickerP2()
            } else if personnagePro.p2Person == "Chevreuil"{
                imagepro2 = #imageLiteral(resourceName: "chevreuil2")
                imagepickerP2()
            } else if personnagePro.p2Person == "Lapin"{
                imagepro2 = #imageLiteral(resourceName: "lapin3")
                imagepickerP2()
            } else if personnagePro.p2Person == "Chat"{
                imagepro2 = #imageLiteral(resourceName: "chat4")
                imagepickerP2()
            } else if personnagePro.p2Person == "Panda" {
                imagepro2 = #imageLiteral(resourceName: "panda5")
                imagepickerP2()
            } else if personnagePro.p2Person == "Zèbre"{
                imagepro2 = #imageLiteral(resourceName: "zebre6")
                imagepickerP2()
            }
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if pickerView.tag == 1 {
            return charactersP1[row]
        } else {
            return charactersP2[row]
        }
    }
    // ACTION BUTTON CHARACTERS MENU

    @IBAction func returnMenu() { print("RETURN TO MENU")
        //superMusic.characterMusic.stop()
    }

    @IBAction func goPlay() { print("PLAY GAME")
        gotoNewGame = true
       superMusic.characterMusic.stop()
        countDownAppear()
    }

    @IBAction func gotoReglageOption() { print("GO TO SETTING OPTION")
        reglageOption.isHidden = false
        viewOption.isHidden = true
        wallpaperSelected()
        defaultImage()
    }
    @IBAction func returntomenu2() {
       superMusic.characterMusic.stop()
    }
    
    
    // MARK: - SETUP GAME OPTION

    @IBOutlet weak var valueTimePerGame: UILabel!
    @IBOutlet weak var valueEnergyPlayer: UILabel!
    @IBOutlet weak var valueAttackPlayer: UILabel!
    @IBOutlet weak var valueRegenerationPlayer: UILabel!

    @IBOutlet weak var switchEsquive: UISwitch!
    @IBOutlet weak var segmentMusicChange: UISegmentedControl!
    @IBOutlet weak var sliderTimePerGame: UISlider!
    @IBOutlet weak var sliderEnergyPerPlayer: UISlider!
    @IBOutlet weak var buttonAttackPlayerValue: UIStepper!
    @IBOutlet weak var buttonRegenerationPlayerValue: UIStepper!

    // MARK: - OPTION MENU

    @IBAction func valueOptionDefault() { print("SET VALUE BY DEFAULT")
        switchEsquive.isOn = true
        segmentMusicChange.selectedSegmentIndex = 0
        game.newGameTime = 20.0
        game.energyPerPlayer = 100
        game.attackValue = 5
        game.regenerationValue = 4
        valueTimePerGame.text = ("\(game.newGameTime)")
        valueTimePerGame.text = NSString(format: "%.0f", game.newGameTime) as String
        valueEnergyPlayer.text = ("\(game.energyPerPlayer)")
        valueAttackPlayer.text = ("\(game.attackValue)")
        valueRegenerationPlayer.text = ("\(game.regenerationValue)")
        sliderTimePerGame.value = game.newGameTime
        sliderEnergyPerPlayer.value = Float(game.energyPerPlayer)
        buttonAttackPlayerValue.value = Double(game.attackValue)
        buttonRegenerationPlayerValue.value = Double(game.regenerationValue)
        defaultImage()
    }

    @IBAction func switchEsquive(_ sender: UISwitch) { print("BUTTON SWITCH PRESS")
    }

    @IBAction func changeMusicSegment(_ sender: Any) { print("Change Option Music")// Change music button
    }
     //Button Option Time slider
    @IBAction func timePerGameButton(_ sender: Any) { // Time per Games
        valueTimePerGame.text = NSString(format: "%.0f", sliderTimePerGame.value) as String
        game.newGameTime = Float(sliderTimePerGame.value)
    }
     //Button Option energy slider
    @IBAction func energyPlayers(_ sender: Any) { // energy player new button
        valueEnergyPlayer.text = NSString(format: "%.0f",sliderEnergyPerPlayer.value) as String
        game.energyPerPlayer = Int(sliderEnergyPerPlayer.value)
    }
     //Button Option Menu attack +-
    @IBAction func attackValueButtonUpdate(_ sender: UIStepper) { // + dattaque
        buttonAttackPlayerValue.wraps = true
        valueAttackPlayer.text = Int(sender.value).description
        game.attackValue = Int(valueAttackPlayer.text!) ?? 0
    }
    //Button Option Menu regeneration +-
    @IBAction func regenerationValueUpdate(_ sender: UIStepper) { //+ de regeneration
        buttonRegenerationPlayerValue.wraps = true
        valueRegenerationPlayer.text = Int(sender.value).description
        game.regenerationValue = Int(valueRegenerationPlayer.text!) ?? 0
    }

    @IBAction func retourauLog() { print("RETURN TO CHARACTERS") // OPTION GAME TO CHARACTER PAGE
        reglageOption.isHidden = true
        viewOption.isHidden = false
    }
   // FUNC OPTION GAME MENU
    func defaultImage() {
        backGroundGameImage = #imageLiteral(resourceName: "WallpaperGame1")
        wallpaperGameImage.image = backGroundGameImage
        game.image1 = 1
        wallpaperSelected()
    }

// MARK: - STATISTIC VIEW

    // MARK: BOUTON STATS VIEW

    @IBOutlet weak var numbergamePlayLabel: UILabel!
    @IBOutlet weak var numberTieGameLabel: UILabel!
    @IBOutlet weak var numberVictoryP1Label: UILabel!
    @IBOutlet weak var numberVictoryP2Label: UILabel!
    @IBOutlet weak var numberGameRestartLabel: UILabel!
    @IBOutlet weak var numberTotalAttackLabel: UILabel!
    @IBOutlet weak var numberTotalAvoidLabel: UILabel!
    @IBOutlet weak var nbDeRegenerationLabel: UILabel!
    @IBOutlet weak var numberOfClickLabel: UILabel!
    @IBOutlet weak var numberAttakP1Label: UILabel!
    @IBOutlet weak var numberAttackP2Label: UILabel!
    @IBOutlet weak var numberAvoidP1Label: UILabel!
    @IBOutlet weak var numberAvoidP2Label: UILabel!
    @IBOutlet weak var nbDeregenerationP1Label: UILabel!
    @IBOutlet weak var nbDeregenerationP2Label: UILabel!
    @IBOutlet weak var timeGamePlayedLabel: UILabel!
    @IBOutlet weak var timeOpenGameGlobalLabel: UILabel!
    @IBOutlet weak var nbMoyByGame: UILabel!

// MARK: ACTION STATISTIC

    @IBAction func statisticMenu() { print("GO TO STATISTIQUE MENU PAUSE")
      
            statsIsOn = true
           superMusic.themeGameMusic.stop()
           superMusic.statsMusic()
            pauseView.isHidden = true
            pause2.isHidden = true
            stats.totalStats()
            stopTimeTotalandGame()
            viewGame.isHidden = true
            statisticMenuPro.isHidden = false
            loadStats()
        
            if playouPause == false {
                pauseView.isHidden = true
                pause2.isHidden = true
                playouPause = true ; print("Now in Play")
                playPauseImage = #imageLiteral(resourceName: "pause")
                buttonplaypause.setImage(playPauseImage, for: [])
            } else {
                
            }
            if musicstats == true {
            } else {
             //   superMusic.endGameMusic.stop()
            }
    }

    var gameEnded = false

    @IBAction func replayGameStatsView() { print("REPLAY GAME IN STATS VIEW")
        superMusic.statsMenuMusic.stop()
        if gameEnded == true {
        replayGameStatsBundle()
        gameEnded = false
        } else {
        replayGameStatsBundle()
        stats.nbAbandonGame += 1
        }
    }
    func replayGameStatsBundle() {
        gotoNewGame = true
        stopTimeTotalandGame()
        statisticMenuPro.isHidden = true
        countDownAppear()
        reloadNewGame()
    }
    @IBAction func returntotheGameinprogress() { print("RETURN TO GAME PAUSE")
       superMusic.statsMenuMusic.stop()
        stopTimeTotalandGame()
        playouPause = true ; print("Now in Play")
        playPauseImage = #imageLiteral(resourceName: "pause")
        buttonplaypause.setImage(playPauseImage, for: [])
        pauseView.isHidden = false
        pause2.isHidden = false
        statisticMenuPro.isHidden = true
        viewGame.isHidden = false
        viewCountdown.isHidden = false
        animation321Go()
    }
    @IBAction func returnLoginfo() { print("GO TO CHARACTERS")
        alertee()
    }
    @IBAction func eraseData() { print("ERASE DATA SUCCESS")
        stats.nbGamePlay = 0
        stats.nbTieGame = 0
        stats.victoryP1 = 0
        stats.victoryP2 = 0
        stats.nbAbandonGame = 0
        stats.nbdAttackP1 = 0
        stats.nbdAttackP2 = 0
        stats.nbdRegenerationP1 = 0
        stats.nbdRegenerationP2 = 0
        stats.nbAvoidP1 = 0
        stats.nbdAvoidP2 = 0
        stats.nbdAvoidTot = 0
        stats.nbdAttackTot = 0
        stats.nbdRegenerationTot = 0
        stats.nbofClick = 0
        loadStats()
    }

// MARK: FUNC STATS VIEW

    func loadStats() {
        numbergamePlayLabel.text = ("\(stats.nbGamePlay)")
        numberTieGameLabel.text = ("\(stats.nbTieGame)")
        numberVictoryP1Label.text = ("\(stats.victoryP1)")
        numberVictoryP2Label.text = ("\(stats.victoryP2)")
        numberGameRestartLabel.text = ("\(stats.nbAbandonGame)")
        numberAttakP1Label.text = ("\(stats.nbdAttackP1)")
        numberTotalAttackLabel.text = ("\(stats.nbdAttackTot)")
        numberAttackP2Label.text = ("\(stats.nbdAttackP2)")
        numberAvoidP1Label.text = ("\(stats.nbAvoidP1)")
        numberAvoidP2Label.text = ("\(stats.nbdAvoidP2)")
        numberTotalAvoidLabel.text = ("\(stats.nbdAvoidTot)")
        numberOfClickLabel.text = ("\(stats.nbofClick)")
        nbDeRegenerationLabel.text = ("\(stats.nbdRegenerationTot)")
        nbDeregenerationP2Label.text = ("\(stats.nbdRegenerationP2)")
        nbDeregenerationP1Label.text = ("\(stats.nbdRegenerationP1)")
    }

// MARK: - GAME VIEW

    @IBOutlet weak var logoJeu: UILabel!
    @IBOutlet weak var replayButton: UIButton!
    @IBOutlet weak var timeAffiche: UILabel!
    @IBOutlet weak var quitTheGame: UIButton!

      // MARK: - DISABLE AVOID

    var playouPause = true //(false = pause ... true = play )
    var esquiveOn = false

      @objc private func timeAvoidP1Func() {
          if game.timeAvoidP1 == 1 { print("TEMPS ÉCOULÉ TOUTE RÉACTIVÉ")
            reactivealloff()
            esquiveOn = false
          } else { print("WAIT TIME AVOID P2 - \(game.timeAvoidP1)")
            game.timeAvoidP1 -= 1
          }
       }

      func avoidTimerP1Time() { // FUNC TO START TIME
          avoidTimerP1 = Timer.scheduledTimer(timeInterval: 1, target: self,
          selector: #selector(timeAvoidP1Func), userInfo: nil, repeats: true)
      }  // AVOIDTIMER = ?.invalidate to pause

    //------------------------

      @objc private func timeAvoidP2Func() {

        if game.timeAvoidP2 == 1 {
            reactivealloff()
            esquiveOn = false
       } else {
            game.timeAvoidP2 -= 1
        }
    }

      func avoidTimerP2Time() { // FUNC TO START TIME
          avoidTimerP2 = Timer.scheduledTimer(timeInterval: 1, target: self,
          selector: #selector(timeAvoidP2Func), userInfo: nil, repeats: true)
      } // AVOIDTIMER = ?.invalidate to pause

      //-------------------------

      @IBAction func esquiveButton1() {
            if switchEsquive.isOn {   print("SWITCH On BOUTON ESQUIVE DESACTIVER POUR JOUEUR 2")
                 esquiveOn = true
              stats.nbAvoidP1 += 1
              avoidTimerP1?.invalidate()
              desactiveJ2on()
              esquiveJ1.isEnabled = false
            } else { print(" SWITCH OFF BOUTON ESQUIVE DESACTIVER POUR JOUEUR 2")
             esquiveOn = true
              stats.nbAvoidP1 += 1
              desactiveJ2off()
              esquiveJ1.isEnabled = false
            }
      }

      @IBAction func esquiveButton2() {
          if switchEsquive.isOn { print("SWITCH ON BOUTON ESQUIVE DESACTIVER POUR JOUEUR 1")
             esquiveOn = true
              stats.nbdAvoidP2 += 1
              avoidTimerP2?.invalidate()
              desactiveJ1on()
              esquiveJ2.isEnabled = false
          } else { print("SWITCH OFF BOUTON ESQUIVE DESACTIVER POUR JOUEUR 1")
             esquiveOn = true
              stats.nbdAvoidP2 += 1
              desactiveJ1off()
              esquiveJ2.isEnabled = false
          }
      }

      func desactiveJ1on() {
          avoidTimerP1?.invalidate()
          buttonEnableFalseP1()
          avoidTimerP1Time()
      }

      func desactiveJ1off() {
          buttonEnableFalseP1()
      }

      func desactiveJ2on() {
          avoidTimerP2?.invalidate()
          buttonEnableFalseP2()
          avoidTimerP1Time()
       }
 /// HERE TO WORKING.... not necessairly
      func desactiveJ2off() {
          buttonEnableFalseP2()
      }

      // REACTIVATION ESQUIVE
      func reactiveJ1on() {
          buttonEnableTrueP1()
      }

      func reactiveJ2on() {
          buttonEnableTrueP2()
      }

      func reactiveJ1off() {
          buttonEnableTrueP1()
      }

      func reactiveJ2off() {
          buttonEnableTrueP2()
      }

      func reactivealloff() { print("BOUTON RÉACTIVER POUR TOUS NO TIME")
          pauseTimerAvoidPlayers()
          game.timeAvoidP1 = 3
          game.timeAvoidP2 = 3
          reactiveJ1off()
          reactiveJ2off()
      }

      func buttonEnableTrueP2() {
          attackP2Label.isEnabled = true
          esquiveJ2.isEnabled = true
          regenerationJ2.isEnabled = true
      }

      func buttonEnableFalseP2() {
          attackP2Label.isEnabled = false
          esquiveJ2.isEnabled = false
          regenerationJ2.isEnabled = false
      }

      func buttonEnableTrueP1() {
          attackP1Label.isEnabled = true
          esquiveJ1.isEnabled = true
          regenerationJ1.isEnabled = true
      }

      func buttonEnableFalseP1() {
          attackP1Label.isEnabled = false
          esquiveJ1.isEnabled = false
          regenerationJ1.isEnabled = false
      }

// MARK: - TIMER ACTION
    
    // TIME IN GAME COUNTDOWN
    
    @objc private func timerDidEnded() {
        game.timeGame -= 0.1
        timeAffiche.text = NSString(format: "%.1f", game.timeGame) as String
        if game.timeGame <= 0 {
            timeAffiche.text = ("0")
            tieGame()
        } else if game.timeGame <= 0 {
            timeAffiche.text = ("0")
            game.timeGame = 0
        }
        }

    func timerGame() {
         timerInGame = Timer.scheduledTimer(timeInterval: 0.1, target: self,
         selector: #selector(timerDidEnded), userInfo: nil, repeats: true)
     }
// TIME GAME PLAY IN GAME
    @objc private func timerGameLoop() {
        game.timePlayed += 0.1
        timeGamePlayedLabel.text = NSString(format: "%.1f", game.timePlayed) as String
            if game.timePlayed <= 1 {
                timeGamePlayedLabel.text = ("0 sec")
            } else {
                stats.moybyGame = (game.timePlayed / Float((1 + stats.nbGamePlay)))
                nbMoyByGame.text = (NSString(format: "%.1f", stats.moybyGame) as String) + " sec" as String
            }
    }

    func timePlayed() {
        timePlayedGame = Timer.scheduledTimer(timeInterval: 0.1, target: self,
        selector: #selector(timerGameLoop), userInfo: nil, repeats: true)
    }

    // TIMER TOTAL GAME
    @objc private func timerGameTotal() {
        game.timeGameOpen += 1
        timeOpenGameGlobalLabel.text = ("\(game.timeGameOpen) sec") as String
     }

    func timeOpenApps() {
        timertot = Timer.scheduledTimer(timeInterval: 1, target: self,
        selector: #selector(timerGameTotal), userInfo: nil, repeats: true)
    }

    func stopTimeTotalandGame() {   print("STOP TIMER GAME AND TOTAL GAME")
            timerInGame?.invalidate()
            timePlayedGame?.invalidate()
    }

      // MARK: - ACTION BUTTON IN GAME

    @IBOutlet weak var buttonplaypause: UIButton!
    var playPauseImage = UIImage(named: "Done")
    var statsIsOn = false
    
    @IBOutlet weak var pause2: UIView!
    @IBAction func pauseGame() {
        
        if playouPause == true { print("NOW IN PAUSE GAME")
           superMusic.themeGameMusic.pause()
            gameEnded = false
            playPauseImage = #imageLiteral(resourceName: "play")
            buttonplaypause.setImage(playPauseImage, for: [])
            pauseTimerAvoidPlayers()
            playouPause = false
            pauseView.isHidden = false
            pause2.isHidden = false
            pauseView.alpha = 0.1
            pause2.alpha = 0.1
            stopTimeTotalandGame()
            if statsIsOn == true {
                pauseView.isHidden = true
                pause2.isHidden = true
                statsIsOn = false
            } else {
                
            }
            if esquiveOn == true { print("Esquive Stop")
                pauseTimerAvoidPlayers()
                buttonplaypause.setImage(playPauseImage, for: [])
                playPauseImage = #imageLiteral(resourceName: "pause")
            } else { print(" No esquive activate")
            }
        } else {
            viewCountdown.isHidden = false
            gameEnded = false
            playouPause = true ; print("Now in Play")
            playPauseImage = #imageLiteral(resourceName: "pause")
            buttonplaypause.setImage(playPauseImage, for: [])
            stopTimeTotalandGame()
            animation321Go()
            }
        }

    func pauseEsquiveRestart() {
        if esquiveOn == true {
            pauseTimerAvoidPlayers()
            avoidTimerP1Time()
            avoidTimerP2Time()
        } else {
        }
    }

    func pauseTimerAvoidPlayers() {
        avoidTimerP1?.invalidate()
          avoidTimerP2?.invalidate()
    }

    @IBAction func attackButton1() {
        game.energyP2 -= game.attackValue
        energyP2Label.text = "\(game.energyP2)"
        gap()
        energieennemie()
        endGameEnd()
        stats.nbdAttackP1 += 1
            if switchEsquive.isOn {
            } else { print("SWITCH OFF BOUTON ESQUIVE REACTIVER POUR JOUEUR 1")
                reactiveJ2off()
                esquiveJ1.isEnabled = true
            }
    }

    @IBAction func reGeneration1() {
        stats.nbdRegenerationP1 += 1
        gap()
        energieennemie()
        if game.energyP1 <= (game.energyPerPlayer - game.regenerationValue) {
                game.energyP1 += game.regenerationValue
                energyP1Label.text = ("\(game.energyP1)")
            } else if game.energyP1 > (game.energyPerPlayer - game.regenerationValue) {
                game.energyP1 = game.energyPerPlayer
                energyP1Label.text = "\(game.energyPerPlayer)"
                gap()
                energieennemie()
            }
             if switchEsquive.isOn {
             } else { print("SWITCH OFF BOUTON ESQUIVE REACTIVER POUR JOUEUR 1")
                reactiveJ2off()
                esquiveJ1.isEnabled = true
             }
    }

    @IBAction func attackButton2() {
        game.energyP1 -= game.attackValue
        stats.nbdAttackP2 += 1
        energyP1Label.text = "\(game.energyP1)"
        gap()
        energieennemie()
        endGameEnd()
            if switchEsquive.isOn {
            } else { print("SWITCH OFF BOUTON ESQUIVE REACTIVER POUR JOUEUR 2")
                reactiveJ1off()
                esquiveJ2.isEnabled = true
            }
    }

    @IBAction func reGeneration2() {
        stats.nbdRegenerationP2 += 1
        game.energyP2 += game.regenerationValue
        gap()
        energieennemie()
            if switchEsquive.isOn {
             } else { print("SWITCH OFF BOUTON ESQUIVE REACTIVER POUR JOUEUR 2")
                reactiveJ1off()
                esquiveJ2.isEnabled = true
             }
        if game.energyP2 <= (game.energyPerPlayer - game.regenerationValue) {
                energyP2Label.text = ("\(game.energyP2)")
            } else if game.energyP2 > (game.energyPerPlayer - game.regenerationValue) {
                game.energyP2 = game.energyPerPlayer
                energyP2Label.text = "\(game.energyPerPlayer)"
                gap()
                energieennemie()
        }
    }

    func gap() {
        var diffE2 = 0
        var diffE1 = 0
        diffE2 = game.energyP1 - game.energyP2
        diffE1 = game.energyP2 - game.energyP1
        energyP1Diff.text = ("\(diffE1)")
        energyP2Diff.text = ("\(diffE2)")
    }

    func energieennemie() { // valeur de avancer et difference entre
        energie1F2.text = ("\(game.energyP1)")
        energie2F1.text = ("\(game.energyP2)")
    }

    // MARK: - FUNC END GAME

    func endGameEnd() {
        if game.energyP1 <= 0 {
        stats.victoryP2 += 1
        wiNner2()
        endGameProcess()
        }
        if game.energyP2 <= 0 {
        stats.victoryP1 += 1
        wiNer1()
        endGameProcess()
        }
    }

    func endGameProcess() {
        stats.nbGamePlay += 1
        stopTimeTotalandGame()
        isHidden()
        superMusic.themeGameMusic.stop()
        replayButton.isHidden = false
    }

    @IBOutlet weak var returngamebuttonoff: UIButton!

    func wiNer1() {
        wiNer()
        energyP1Label.text = "\(String(describing: infoPlayer1.text!)) a gagné"
        energyP2Label.text = "\(String(describing: infoPlayer1.text!)) a gagné"
    }

    func wiNner2() {
        wiNer()
        energyP1Label.text = "\(String(describing: infoPlayer2.text!)) a gagné"
        energyP2Label.text = "\(String(describing: infoPlayer2.text!)) a gagné"
    }

    func wiNer() {
        returngamebuttonoff.isEnabled = false
        musicstats = false
       superMusic.endGamesound()
        gameEnded = true
        textSize()
        playpausedisappear()
        stopTimeTotalandGame()
    }

    func playpausedisappear() {
        buttonplaypause.setImage(playPauseImage, for: [])
        buttonplaypause.isEnabled = false
    }

    func playpauseappear() {
        playPauseImage = #imageLiteral(resourceName: "pause")
        buttonplaypause.setImage(playPauseImage, for: [])
        buttonplaypause.isEnabled = true
    }

    func tieGame() {
        returngamebuttonoff.isEnabled = false
        musicstats = false
      superMusic.endGamesound()
        gameEnded = true
        replayButton.isHidden = false
        stopTimeTotalandGame()
        playpausedisappear()
        avoidTimerP1?.invalidate()
        avoidTimerP2?.invalidate()
        print("partie nul")
        isHidden()
       superMusic.themeGameMusic.stop()
        textSize2()
        stats.nbGamePlay += 1
        stats.nbTieGame += 1
        energyP1Label.text = "TEMPS ÉCOULÉ PARTIE NUL"
        energyP2Label.text = "TEMPS ÉCOULÉ PARTIE NUL"
    }

    func reloadNewGame() {
        allOnForNewGame()
        resetGame()
    }

    func isHidden() {
        attackP1Label.isHidden = true
        attackP2Label.isHidden = true
        esquiveJ1.isHidden = true
        esquiveJ2.isHidden = true
        regenerationJ1.isHidden = true
        regenerationJ2.isHidden = true
        energie1F2.isHidden = true
        energie2F1.isHidden = true
        energyP1Diff.isHidden = true
        energyP2Diff.isHidden = true
    }

    var musicStatus = Bool()

    func musicPauseOrNewGame() {
        if musicStatus == true {
          superMusic.musicInGame()
        } else {
          superMusic.themeGameMusic.play()
        }
    }

    // MARK: - NEW GAME

    func startGame() {
        rotationtrue = true
        returngamebuttonoff.isEnabled = true
        musicStatus = true
        viewGame.isHidden = false
        replayButton.isHidden = true
        viewOption.isHidden = true
        clavierTuning()
        playpauseappear()
        reactivealloff() // REACTIVE ALL BUTTON
        reloadNewGame()
        numberGameRestartLabel.text = ("\(stats.nbAbandonGame)")
        timerGame()
        timePlayed()
        game.timeGame = game.newGameTime
        timeAffiche.text = NSString(format: "%.0f", game.newGameTime) as String
        nameCharactersP1.text = ("\(personnagePro.p1Person)")
        nameCharactersP2.text = ("\(personnagePro.p2Person)")

        switch segmentMusicChange.selectedSegmentIndex {
        case 0:
          superMusic.musicInGame()
        case 1:
            print("nothing")
        default:
            break
        }
    }

    func resetGame() {  // lors de l'appuie sur Rejouer
        game.energyP1 = game.energyPerPlayer
        game.energyP2 = game.energyPerPlayer
        energyP1Label.text = ("\(game.energyPerPlayer)")
        energyP2Label.text = ("\(game.energyPerPlayer)")
        energyP2Diff.text = "Avance"
        energyP1Diff.text = "Avance"
        energie1F2.text = ("\(game.energyPerPlayer)")
        energie2F1.text = ("\(game.energyPerPlayer)")
        allOnForNewGame()
    }

    func allOnForNewGame() {
        quitTheGame.isHidden = false
        attackP1Label.isHidden = false
        attackP2Label.isHidden = false
        esquiveJ1.isHidden = false
        esquiveJ2.isHidden = false
        regenerationJ1.isHidden = false
        regenerationJ2.isHidden = false
        energie1F2.isHidden = false
        energie2F1.isHidden = false
        energyP1Diff.isHidden = false
        energyP2Diff.isHidden = false
    }

    @IBAction func rePlay() {
        gotoNewGame = true
       superMusic.endGameMusic.stop()
        countDownAppear()
        stopTimeTotalandGame()
        reloadNewGame()
    }
    // MARK: - Rotation Player 2

    func rotationPlayer2() { //Rotation du texte Joueur 2
        energyP2Label.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        attackP2Label.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        esquiveJ2.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        logoJeu.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        regenerationJ2.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        infoPlayer2.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        energie1F2.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        energyP1Diff.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        imageCharactersP2.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        nameCharactersP2.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    // MARK: - FOND CHANGE

    var backGroundGameImage = UIImage(named: "WallPaperGame1")
    @IBOutlet weak var wallpaperGameImage: UIImageView!
    @IBOutlet weak var backGround1button: UIButton!
    @IBOutlet weak var backGround2button: UIButton!
    @IBOutlet weak var backGround3button: UIButton!

    @IBAction func wallpaperGame1(_ sender: Any) {
        backGroundGameImage = #imageLiteral(resourceName: "WallpaperGame1")
        wallpaperGameImage.image = backGroundGameImage
        game.image1 = 1
        wallpaperSelected()
    }

    @IBAction func wallPaperGame2(_ sender: Any) {
        backGroundGameImage = #imageLiteral(resourceName: "WallpaperGame2")
        wallpaperGameImage.image = backGroundGameImage
        game.image1 = 2
        wallpaperSelected()
    }

    @IBAction func wallPaperGame3(_ sender: Any) {
        backGroundGameImage = #imageLiteral(resourceName: "WallpaperGame3")
        wallpaperGameImage.image = backGroundGameImage
        game.image1 = 3
        wallpaperSelected()
    }
    // Choice Wallpaper selected
    func wallpaperSelected() {
        if game.image1 == 1 {
            backGround1button.layer.borderWidth = 3
            backGround2button.layer.borderWidth = 0
            backGround3button.layer.borderWidth = 0
        } else if game.image1 == 2 {
            backGround2button.layer.borderWidth = 3
            backGround1button.layer.borderWidth = 0
            backGround3button.layer.borderWidth = 0
        } else if game.image1 == 3 {
            backGround3button.layer.borderWidth = 3
            backGround1button.layer.borderWidth = 0
            backGround2button.layer.borderWidth = 0
        }
    }
      // MARK: - ANIMATION 321GO

    func test() {
        backNumber321 = #imageLiteral(resourceName: "3")
        iMAGE321GO.image = backNumber321
        iMAGE321GO.isHidden = false
        self.iMAGE321GO.alpha = 1.0
        self.iMAGE321GO.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
    }

    func testpro2() {
        backNumber321 = #imageLiteral(resourceName: "3")
        iMAGE321GO.image = backNumber321
        iMAGE321GO.isHidden = true
    }

    func test2() {
        backNumber321 = #imageLiteral(resourceName: "2")
        iMAGE321GO.image = backNumber321
        rotationCountdown()
        }

    func test3() {
        backNumber321 = #imageLiteral(resourceName: "1")
        iMAGE321GO.image = backNumber321
        rotationCountdown()
    }

    func test4() {
            backNumber321 = #imageLiteral(resourceName: "GO")
            iMAGE321GO.image = backNumber321
            rotationCountdown()
    }

    func countDownAppear() {
            test() ; print("3")
            viewCountdown.isHidden = false
            viewGame.isHidden = false
            self.viewCountdown.alpha = 0.1
            animation321Go()
    }

    func rotationCountdown() {
        UIView.animate(withDuration: 1, animations: {
            self.iMAGE321GO.alpha = 1.0
            self.iMAGE321GO.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.iMAGE321GO.transform = CGAffineTransform(rotationAngle: (CGFloat.pi))}){ (completed) in
           }
    }

    @IBOutlet weak var viewCountdown: UIView!
    var backNumber321 = UIImage(named: "3")

    @IBOutlet weak var iMAGE321GO: UIImageView!

    func countDownAppear22() {
            timerInGame?.invalidate()
          viewCountdown.isHidden = false
          viewGame.isHidden = false
          self.viewCountdown.alpha = 0.1
          animation321Go()
      }

        // VERSION 1 ANIMATE FIRST LOOK
    func animation321Go() { // Test the other method for animation.. where?
        iMAGE321GO.isHidden = false
        UIView.animate(withDuration: 0.2,delay: 0.2, animations: { //END
            self.rotationCountdown()
            self.iMAGE321GO.alpha = 1.0
            self.iMAGE321GO.transform = CGAffineTransform(scaleX: 1.3, y: 1.3) }) { (completed) in     //1
        UIView.animate(withDuration: 0.2, animations: {
            self.iMAGE321GO.transform = CGAffineTransform(scaleX: 0.7, y: 0.7) }) { (completed) in
        UIView.animate(withDuration: 0.3, delay: 0.1, animations: {
            self.iMAGE321GO.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.iMAGE321GO.alpha = 0.0 }) { (completed) in
        UIView.animate(withDuration: 0.2, delay: 0.2, animations: {  //-- 2
            self.test2(); print("2")//4.apparition du
            self.iMAGE321GO.transform = CGAffineTransform(scaleX: 1.3, y: 1.3) }) { (completed) in        //1.Expansion #3
        UIView.animate(withDuration: 0.2, animations: {
            self.iMAGE321GO.transform = CGAffineTransform(scaleX: 0.7, y: 0.7) }) { (completed) in     //2.Scaledown #3
        UIView.animate(withDuration: 0.3, delay: 0.1, animations: {
            self.iMAGE321GO.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.iMAGE321GO.alpha = 0.0 }) { (completed) in
        UIView.animate(withDuration: 0.2, delay: 0.2, animations: { //-- 1
            self.test3() ; print("1")
            self.iMAGE321GO.transform = CGAffineTransform(scaleX: 1.3, y: 1.3) }) { (completed) in
        UIView.animate(withDuration: 0.2, animations: { //1
            self.iMAGE321GO.transform = CGAffineTransform(scaleX: 0.7, y: 0.7) }) { (completed) in  //2.Scaledown #3
            UIView.animate(withDuration: 0.3, delay: 0.1, animations: {
            self.iMAGE321GO.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.iMAGE321GO.alpha = 0.0 })
            {(completed) in
        UIView.animate(withDuration: 0.2, delay: 0.2, animations: {   //-- Go
            self.test4(); print("GO")
            self.iMAGE321GO.transform = CGAffineTransform(scaleX: 1.3, y: 1.3) }) { (completed) in
        UIView.animate(withDuration: 0.2, animations: {
            self.iMAGE321GO.transform = CGAffineTransform(scaleX: 0.7, y: 0.7) }) { (completed) in     //2.Scaledown #3
        UIView.animate(withDuration: 0.3, delay: 0.1, animations: {
            self.iMAGE321GO.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.iMAGE321GO.alpha = 0.0 }) { (completed) in
            // if New Game or Pause Game

            if self.gotoNewGame == true {
            self.viewCountdown.isHidden = true
            self.testpro2()
            self.startGame()
            self.pauseEsquiveRestart()
            self.gotoNewGame = false
            } else {
                self.testpro2()
                self.pauseView.isHidden = true
                self.pause2.isHidden = true
                self.viewCountdown.isHidden = true
                self.timerGame()
                self.timePlayed()
                self.pauseEsquiveRestart()
                self.musicStatus = false
                self.musicPauseOrNewGame()
                self.gotoNewGame = false
            } // end
                                                    } //12
                                                } //11
                                            } //10
                                        } //9
                                    } //8
                                }//7
                            }//6
                        } //5
                    }//4
                }// 3
            } // 2
        } // 1
    } // anima
    
    // ROTATION ALL GAME
    
    @IBOutlet weak var GAPP1: UILabel!
    @IBOutlet weak var EnergyP1Rotation: UILabel!
    @IBOutlet weak var EnergyP2FORP1Rotation: UILabel!
    
    
    
    var rotationtrue = false
         override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
               super.viewWillTransition(to: size, with: coordinator)
               if UIDevice.current.orientation.isLandscape {
                   print("Landscape")
                if rotationtrue == true {
                //    rotationtrue = false
                    wallpaperGameImage.isHidden = true
                     GAPP1.transform = CGAffineTransform(rotationAngle: 90)
                     EnergyP1Rotation.transform = CGAffineTransform(rotationAngle: 90)
                     EnergyP2FORP1Rotation.transform = CGAffineTransform(rotationAngle: 90)
                    print("BONJOUR L'IMAGE")
                  //  rotationGameOn()
                } else {
                 //   rotationtrue = false
                    wallpaperGameImage.isHidden = false
                   print("BYE IMAGE")
                   // rotationGameOn()
                }
               
               } else {
               // rotationtrue = true
                wallpaperGameImage.isHidden = false
                   print("Portrait")
                print("BYE IMAGE")
              //  rotationGameOn()
               }
    }
    
    @IBOutlet weak var P1scoreStackView: UIStackView!
    @IBOutlet weak var P2scoreStackView: UIStackView!
    
    @IBOutlet weak var CenterStackView: UIStackView!
    
    @IBOutlet weak var GameP1StackView: UIStackView!
    
    @IBOutlet weak var GameP2StackView: UIStackView!
    func rotationGameOn() {
           imageCharactersP1.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                   imageCharactersP2.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        replayButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            P1scoreStackView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
              P2scoreStackView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
              CenterStackView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
              GameP1StackView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
              GameP2StackView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    func rotationGameOff() {
        
    }
}// END CODE
// MARK: - END CODE 1264 Lines
