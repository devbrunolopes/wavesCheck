//
//  ChooseForecastViewModel.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 09/06/22.
//

import Foundation


class ChooseForecastViewModel {
    
    var statesBeaches: [StatesModel] = [
        StatesModel(state: "São Paulo", opened: false, beaches: ["Guarujá", "Santos", "Maresias", "Camburi", "Ubatuba"]),
        StatesModel(state: "Rio de Janeiro", opened: false, beaches: ["Grumari", "Prainha", "Praia da Macumba", "Itacoatiara", "Canto do Recreio"]),
        StatesModel(state: "Santa Catarina", opened: false, beaches: ["Florianópolis", "Imbituba", "Garopaba", "Bombinhas", "Balneário Cambuiriú"]),
        StatesModel(state: "Espírito Santo", opened: false, beaches: ["Regência", "Jacaraípe", "Solemar", "Barrote", "Amigão"]),
        StatesModel(state: "Paraná", opened: false, beaches: ["Guaratuba", "Matinhos", "Ilha do Mel", "Pontal do Paraná", "Paraguaios"]),
        StatesModel(state: "Bahia", opened: false, beaches: ["Prainha", "Farol da Barra", "Stella", "Vilas do Atlântico", "Pescador"]),
        StatesModel(state: "Pernambuco", opened: false, beaches: ["Cacimba do Padre", "Praia da Conceição", "Praia do Boldró", "Praia do Meio", "Praia do Bode"]),
        StatesModel(state: "Rio Grande do Norte", opened: false, beaches: ["Baía Formosa", "Pontal", "Pipa", "Artistas", "Escadaria"])
    ]
    
    var state: [State] = [
        State(state: "São Paulo", opened: false),
        State(state: "Rio de Janeiro", opened: false),
        State(state: "Santa Catarina", opened: false),
        State(state: "Espírito Santo", opened: false),
        State(state: "Paraná", opened: false),
        State(state: "Bahia", opened: false),
        State(state: "Pernambuco", opened: false),
        State(state: "Rio Grande do Norte", opened: false)
    ]
    
}
