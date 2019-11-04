//
//  Music.swift
//  Jeu De Combat
//
//  Created by Martin Ménard on 2019-08-31.
//  Copyright © 2019 Martin Ménard. All rights reserved.
//

import Foundation
import AVFoundation

class Music {

    
    var themeGameMusic = AVAudioPlayer() //declare as Globally
    var soundthree = AVAudioPlayer()
    var soundtwo = AVAudioPlayer()
    var soundone = AVAudioPlayer()
    var statsMenuMusic = AVAudioPlayer()
    var optionMusic = AVAudioPlayer()
    var endGameMusic = AVAudioPlayer()
    var characterMusic = AVAudioPlayer()

    func musicInGame() {
            
            guard let sasound = Bundle.main.path(forResource: "rush2", ofType: "mp3") else {
                print("error to get the mp3 file")
                return
            }
            do {
                themeGameMusic = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sasound))
            } catch {
                print("audio file error")
            }
          themeGameMusic.play()
        }
        


    func charactersMenuMusic() {

           guard let sound = Bundle.main.path(forResource: "optionGameMusic", ofType: "mp3") else {
               print("error to get the mp3 file")
               return
           }
           do {
               characterMusic = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
           } catch {
               print("audio file error")
           }
           characterMusic.play()
       }
      func statsMusic() {

        guard let sound = Bundle.main.path(forResource: "statsMusic", ofType: "mp3") else {
            print("error to get the mp3 file")
            return
        }
        do {
            statsMenuMusic = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
        } catch {
            print("audio file error")
        }
        statsMenuMusic.play()
    }
      func optionMusicMenu() {

        guard let sound = Bundle.main.path(forResource: "optionGameMusic", ofType: "mp3") else {
            print("error to get the mp3 file")
            return
        }
        do {
            optionMusic = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
        } catch {
            print("audio file error")
        }
        optionMusic.play()
    }
      func endGamesound() {

        guard let sound = Bundle.main.path(forResource: "endGameMusic", ofType: "mp3") else {
            print("error to get the mp3 file")
            return
        }
        do {
            endGameMusic = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
        } catch {
            print("audio file error")
        }
        endGameMusic.play()
    }
}
