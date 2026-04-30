//
//  Stitch.swift
//  kroxê
//
//  Created by User on 27/04/26.
//

enum Stitch: Identifiable, Codable, CaseIterable {
    case chain, magicRing, slipStitch, singleCrochet, halfDoubleCrochet, doubleCrochet, trebleCrochet, doubleTrebleCrochet, increase, decrease
    var id: Self { self }
    
    var allNames: [String] {
        switch self {
        case .chain:
            return [" ch", " corr", " chain", " correntinha"]
        case .magicRing:
            return [" magic ring", " anel magico", " anel mágico", " mr",]
        case .slipStitch:
            return [" ponto baixíssimo", " ponto baixissimo", " slip stitch", " pbx", " sl st"]
        case .singleCrochet:
            return [" sc", " single crochet", " pb", " ponto baixo"]
        case .halfDoubleCrochet:
            return [" mpa", " meio ponto alto", " half double crochet", " hdc"]
        case .doubleCrochet:
            return [" pa", " ponto alto", " double crochet", " dc"]
        case .doubleTrebleCrochet:
            return [" pad", " ponto alto duplo", " treple crochet", " tr"]
        case .trebleCrochet:
            return [" pat", " ponto alto triplo", " double treble crochet", " dtr"]
        case .increase:
            return [" inc", " increase", " aumento", " aum"]
        case .decrease:
            return [" diminuição", " diminuiçao", " diminuicao", " diminuicão", " dim", " decrease", " dec"]
        }
    }
    
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
        case .chain: return "Chain (ch)"
        case .magicRing: return "Magic Ring (mr)"
        case .slipStitch: return "Slip Stitch (sl st)"
        case .singleCrochet: return "Single Crochet (sc)"
        case .halfDoubleCrochet: return "Half Double Crochet (hdc)"
        case .doubleCrochet: return "Double Crochet (dc)"
        case .trebleCrochet: return "Treble Crochet (tr)"
        case .doubleTrebleCrochet: return "Double Treble Crochet (dtr)"
        case .increase: return "Increase (inc)"
        case .decrease: return "Decrease (dec)"
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
    
    init?(name: String) {
        let stitch = Stitch.allCases.first { stitch in
            stitch.allNames.contains(name.lowercased())
        } // .singleCrochet
        if let stitch {
            self = stitch // self = .singleCrochet
        } else {
            return nil
        }
    }
    
}

