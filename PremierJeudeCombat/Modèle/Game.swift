//
//  Game.swift
//  PremierJeudeCombat
//
//  Created by Martin Ménard on 2019-08-17.
//  Copyright © 2019 Martin Ménard. All rights reserved.
//
// MARK: - IMPORT

import Foundation

// MARK: - CLASS STATISTIQUES
class Statistic : Game {

    var nbGamePlay = 0
    var nbTieGame = 0
    var victoryP1 = 0
    var victoryP2 = 0
    var nbAbandonGame = 0
    var nbdAttackP1 = 0
    var nbdAttackP2 = 0
    var nbdAttackTot = 0
    var nbdRegenerationP1: Int = 0
    var nbdRegenerationP2 = 0
    var nbdRegenerationTot = 0
    var nbAvoidP1 = 0
    var nbdAvoidP2 = 0
    var nbdAvoidTot = 0
    var nbofClick = 0
    var moybyGame: Float = 1

// MARK: - FUNC CLASS

    func abandonGame() {
        nbAbandonGame += 1
    }

    func totalStats() {
        nbdRegenerationTot = nbdRegenerationP2 + nbdRegenerationP1
        nbdAttackTot = nbdAttackP1 + nbdAttackP2
        nbdAvoidTot = nbAvoidP1 + nbdAvoidP2
        nbofClick = nbdRegenerationTot + nbdAvoidTot + nbdAttackTot

    }
}

// MARK: - CLASS JEU
class Game {

    var energyP1 = 100
    var energyP2 = 100
    var energyDiff = 0
    var timeGame: Float = 20
    var timePlayed: Float = 0
    var timeGameOpen = 0
    var timeAvoidP1 = 3
    var timeAvoidP2 = 3
    var image1 = 1
    // BOOL
    var pauseGame = false

    // BUTTON OPTION NEW VAR
    var newGameTime: Float = 20.0
    var energyPerPlayer = 100
    var attackValue = 5
    var regenerationValue = 4

    func energyLostJ1() {
        energyP1 -= 5
    }

    func energyLostJ2() {
        energyP2 -= 5
    }

    func regenerationUpP1() {
    }

    func regenerationUpP2() {

    }
}

// MARK: - CLASS SAVED GAME

// FUTURE DATA
class SavedGame {

    var savePartieJouer = 0
    var savePartieNul = 0
    var saveVictoireJ1 = 0
    var saveVictoireJ2 = 0
}
