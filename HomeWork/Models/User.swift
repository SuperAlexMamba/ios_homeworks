//
//  User.swift
//  Navigation
//
//  Created by Слава Орлов on 04.03.2023.
//

import Foundation
import UIKit

class User {
    
    var login: String
    var password: String
    var status: String
    var image: UIImage
    var post: [Post]
    
    init(login: String, password: String, status: String, image: UIImage, post: [Post]) {
        self.login = login
        self.password = password
        self.status = status
        self.image = image
        self.post = post
    }
}

class Post {
    
    var author: String
    var text: String
    var image: UIImage
    var likes: Int
    var views: Int
    
    init(author: String, user: String? = nil, text: String, image: UIImage, likes: Int, views: Int) {
        self.author = author
        self.text = text
        self.image = image
        self.likes = likes
        self.views = views
    }
}

class FeedItem {
    
    var user: User
    var post: Post
    
    init(user: User, post: Post) {
        self.user = user
        self.post = post
    }
    
}

var postOne = Post(author: "the.wither.fans", text: "Наш с вами любимый Геральт из Ривии", image: UIImage(named: "wither")!, likes: 442, views: 1600)

var postTwo = Post(author: "space.life", text: "Красота космоса", image: UIImage(named: "space")!, likes: 255, views: 871)

var postThree = Post(author: "vikiped.ia", text: "Восста́ние Спарта́ка́ — величайшее в древности и третье по счёту (после первого и второго Сицилийских восстаний) восстание рабов.Восстание Спартака было единственным восстанием рабов, представлявшим прямую угрозу центральной Италии. Окончательно подавлено, в основном, благодаря военным усилиям полководца Марка Лициния Красса. В последующие годы оно продолжало оказывать косвенное воздействие на политику Рима.", image: UIImage(named: "spartacus")!, likes: 2185, views: 8456)

var postFour = Post(author: "game.of.thrones", text: "кадры последнего 8 сезона сериала Игра Престолов ", image: UIImage(named: "game")!, likes: 543, views: 1407)

var postFive = Post(author: "vikiped.ia", user: "anonymous", text: "Остров в Малайском архипелаге, в группе Малых Зондских островов, в составе одноимённой провинции Индонезии. Омывается с юга Индийским океаном, с севера — морем Бали Тихого океана. С запада отделён одноимённым проливом от острова Ява, с востока — Ломбокским проливом от острова Ломбок.", image: UIImage(named: "bali")!, likes: 435, views: 1090)

var postSix = Post(author: "city.life", user: "dog", text: "Город в штате Калифорния,США; административный центр округа Сан-Франциско. Культурный, коммерческий, финансовый центр Северной Калифорнии.Назван в честь католического святого (по-испански San) Франциска Ассизского.Население в 2017 году составляло 884 363 человек, это четвёртый по численности населения город Калифорнии и двенадцатый в США.", image: UIImage(named: "san-francisco")!, likes: 555, views: 1011)

var postSeven = Post(author: "top.gear", user: "userMan", text: "Дрэг-рейсинг — это гоночное соревнование, являющееся спринтерским заездом (гоночным заездом на короткое расстояние) с участием двух автомобилей.", image: UIImage(named: "dragRacing")!, likes: 1354, views: 3544)

var postEight = Post(author: "vikiped.ia", user: "userMan", text: "Точка пересечения оси вращения Земли с её поверхностью в Северном полушарии. Находится в центральной части Северного Ледовитого океана.", image: UIImage(named: "the north pole")!, likes: 4315, views: 22544)

let userOne = User(login: "anonymous", password: "#@$$@#$wd123", status: "Hack you", image: UIImage(named: "anonymous")!, post: [postEight])

let userTwo = User(login: "Happy_Dog", password: "GavGav321", status: "I love peoples", image: UIImage(named: "dog")!, post: [postSeven])

let userThree = User(login: "Developer", password: "Hell0-W0rld1", status: "101 !", image: UIImage(named: "userMan")!, post: [postSix, postFive])

let superUser = User(login: "HipsterCat", password: "123231", status: "Waiting for something...", image: UIImage(named: "hipsterCat")!, post: [postOne,postTwo,postThree,postFour])
