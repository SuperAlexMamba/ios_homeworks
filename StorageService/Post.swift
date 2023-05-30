//
//  Posty.swift
//  Navigation
//
//  Created by Слава Орлов on 26.01.2023.
//

import Foundation

public struct Post{
    
    public var author: String
    public var text: String
    public var image: String
    public var likes: Int
    public var views: Int

}

public var postOne = Post(author: "the.wither.fans", text: "Наш с вами любимый Геральт из Ривии", image: "wither", likes: 442, views: 1600)

public var postTwo = Post(author: "space.life", text: "Красота космоса", image: "space", likes: 255, views: 871)

public var postThree = Post(author: "vikiped.ia", text: "Восста́ние Спарта́ка́ — величайшее в древности и третье по счёту (после первого и второго Сицилийских восстаний) восстание рабов.Восстание Спартака было единственным восстанием рабов, представлявшим прямую угрозу центральной Италии. Окончательно подавлено, в основном, благодаря военным усилиям полководца Марка Лициния Красса. В последующие годы оно продолжало оказывать косвенное воздействие на политику Рима.", image: "spartacus", likes: 2185, views: 8456)

public var postFour = Post(author: "game.of.thrones", text: "кадры последнего 8 сезона сериала Игра Престолов ", image: "game", likes: 543, views: 1407)
