//
//  MockMoviesService.swift
//  AppArchitecture
//
//  Created by Jean Ricardo Cesca on 10/11/22.
//

import Foundation

class MockMoviesService: MoviesServicing {
    
    func getMovies(_ completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        
        let response = MovieResponse(results: [
            Movie(id: 436270, title: "Black Adam", overview: "Nearly 5,000 years after he was bestowed with the almighty powers of the Egyptian gods—and imprisoned just as quickly—Black Adam is freed from his earthly tomb, ready to unleash his unique form of justice on the modern world.", posterPath: "/3zXceNTtyj5FLjwQXuPvLYK5YYL.jpg"),
            Movie(id: 900667, title: "One Piece Film Red", overview: "Uta — the most beloved singer in the world. Her voice, which she sings with while concealing her true identity, has been described as “otherworldly.” She will appear in public for the first time at a live concert. As the venue fills with all kinds of Uta fans — excited pirates, the Navy watching closely, and the Straw Hats led by Luffy who simply came to enjoy her sonorous performance — the voice that the whole world has been waiting for is about to resound.", posterPath: "/m80kPdrmmtEh9wlLroCp0bwUGH0.jpg"),
            Movie(id: 724495, title: "The Woman King", overview: "The story of the Agojie, the all-female unit of warriors who protected the African Kingdom of Dahomey in the 1800s with skills and a fierceness unlike anything the world has ever seen, and General Nanisca as she trains the next generation of recruits and readies them for battle against an enemy determined to destroy their way of life.", posterPath: "/438QXt1E3WJWb3PqNniK0tAE5c1.jpg"),
        ])
        
        completion(.success(response))
    }

}
