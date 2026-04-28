//
//  Stitch.swift
//  kroxê
//
//  Created by User on 27/04/26.
//

enum Stitch: Identifiable, Codable {
    case chain, magicRing, slipStitch, singleCrochet, halfDoubleCrochet, doubleCrochet, trebleCrochet, doubleTrebleCrochet, increase, decrease
    var id: Self { self }
    
    var name: String {
        switch self {
        case .chain: return "Correntinha"
        case .magicRing: return "Anel Mágico"
        case .slipStitch: return "Ponto Baixíssimo"
        case .singleCrochet: return "Ponto Baixo"
        case .halfDoubleCrochet: return "Meio Ponto Alto"
        case .doubleCrochet: return "Ponto Alto"
        case .trebleCrochet: return "Ponto Alto Duplo"
        case .doubleTrebleCrochet: return "Ponto Alto Triplo"
        case .increase: return "Aumento"
        case .decrease: return "Diminuição"
        }
    }
    
    var abreviatedName: String {
        switch self {
        case .chain: return "corr"
        case .magicRing: return "mr"
        case .slipStitch: return "pbx"
        case .singleCrochet: return "pb"
        case .halfDoubleCrochet: return "mpa"
        case .doubleCrochet: return "pa"
        case .trebleCrochet: return "pad"
        case .doubleTrebleCrochet: return "pat"
        case .increase: return "aum"
        case .decrease: return "dim"
        }
    }
    
    var translation: String {
        switch self {
        case .chain: return "Chain"
        case .magicRing: return "Magic Ring"
        case .slipStitch: return "Slip Stitch"
        case .singleCrochet: return "Single Crochet"
        case .halfDoubleCrochet: return "Half Double Crochet"
        case .doubleCrochet: return "Double Crochet"
        case .trebleCrochet: return "Treble Crochet"
        case .doubleTrebleCrochet: return "Double Treble Crochet"
        case .increase: return "Increase"
        case .decrease: return "Decrease"
        }
    }
    
    var description: String {
        switch self {
        case .chain: return "Ponto base para iniciar projetos, especialmente retangulares."
        case .magicRing: return "Ponto inicial para projetos redondos com acabamento invisível."
        case .slipStitch: return "Normalmente para fazer acabamentos."
        case .singleCrochet: return "Ponto básico com altura de 1 corrente."
        case .halfDoubleCrochet: return "Ponto intermediário com altura de 2 correntes."
        case .doubleCrochet: return "Ponto básico com altura de 3 correntes."
        case .trebleCrochet: return "Ponto avançado com altura de 4 correntes."
        case .doubleTrebleCrochet: return "Ponto avançado com altura de 4 correntes."
        case .increase: return "Pode ser feito com qualquer ponto, desde que faça 2 ao invés de 1 ponto."
        case .decrease: return "Pode ser feito com qualquer ponto, desde que junte 2 pontos em 1."
        }
    }
    
    var image: String {
        switch self {
        case .chain: return "Ch"
        case .magicRing: return "Mr"
        case .slipStitch: return "SlSt"
        case .singleCrochet: return "Sc"
        case .halfDoubleCrochet: return "Hdc"
        case .doubleCrochet: return "Dc"
        case .trebleCrochet: return "Tr"
        case .doubleTrebleCrochet: return "Dtr"
        case .increase: return "Inc"
        case .decrease: return "Dec"
        }
    }
}
