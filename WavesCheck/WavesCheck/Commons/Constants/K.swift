//
//  K.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 09/06/22.
//

import Foundation

enum K: String {
    case appName = "WavesCheck"
    case emptyString = ""
    case forgotPasswordLabel = "Use seu email cadastrado para recuperar a senha:"
    case cupertino = "cupertino"
    case nearLocation = "Locais próximos"
    case bestSpots = "Melhores spots"
    
    enum Firebase: String {
        case wavesCheckReports = "wavesCheck/reports"
        case nameLocation = "nameLocation"
        case wavezSize = "wavesSize"
        case surfCondition = "surfCondition"
        case surfImage = "surfImage"
        case reportDate = "reportDate"
        case images = "images"
        case url = "url"
    }
    
    enum Images: String {
        case waves = "waves"
        case back = "back"
        case duck = "duckSurfer"
        case selfLocation = "location.circle.fill"
        case magnifyingglass = "magnifyingglass"
        case goButton = "arrow.right.circle"
        case wavesIcon = "waveIcon"
        case clock = "clock"
        case locationCircle = "location.circle"
        case wind = "wind"
        case chevronDown = "chevron.down"
    }
    
    enum TextFields: String {
        case email = "Digite seu email"
        case password = "Digite a sua senha"
        case name = "Digite seu nome"
        case search = "Search"
    }
    
    enum Buttons: String {
        case forgotPassword = "Esqueceu a senha?"
        case signIn = "Entrar"
        case register = "Cadastrar"
        case noAccount = "Não tem conta? Cadastre-se"
        case send = "Enviar"
        case openInMaps = "Abrir no Mapas"
        case addPicture = "Adicionar foto"
        case addReport = "Adicionar Report"
        case back = "Voltar"
    }
    
    enum Alerts: String {
        case iza = "Izaaaa"
        case ops = "Ops"
        case wrongData = "Email e/ou senha incorretos!"
        case wipeOut = "O servidor tomou uma vaca, tente novamente na próxima série!"
        case sentEmail = "Email enviado com sucesso, verifique sua caixa de email/spam em instantes!"
        case locationExperience = "Para uma melhor experiência, autorizar o uso da sua localização!"
        case noLocationFound = "Não encontramos nenhuma localização :("
        case noDirections = "Não conseguimos encontrar um caminho, tente novamente!"
    }
    
    enum URL: String {
        case mapsApp = "http://maps.apple.com/?q="
    }
    
    enum CellIdentifier: String {
        case nearLocationsTableViewCell = "NearLocationsTableViewCell"
        case reportsTableViewCell = "ReportsTableViewCell"
        case forecastTableViewCell = "ForecastTableViewCell"
        case chooseForecastHeaderView = "ChooseForecastHeaderView"
        case chooseForecastTableViewCell = "ChooseForecastTableViewCell"
    }
    
    enum Labels: String {
        case addNewReports = "Adicionar um novo report"
        case location = "Local:"
        case size = "Tamanho:"
        case condition = "Condição:"
        case wavesSize = " - Tamanho das ondas"
        case period = " - Período entre as séries"
        case swellDirection = " - Direção do swell"
        case windSpeedDirection = " - Velocidade e direção do vento"
    }
    
}
