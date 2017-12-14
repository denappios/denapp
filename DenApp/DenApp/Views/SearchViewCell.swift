//
//  TableViewCell.swift
//  DenApp
//
//  Created by Pelorca on 13/12/2017.
//  Copyright © 2017 DenApp. All rights reserved.
//

import UIKit


class SearchViewCell: UITableViewCell {
    
    @IBOutlet weak var typeDen: UIImageView!
    @IBOutlet weak var txtTitulo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class Den {
    let title: String
    let typeDen: Int
    let latitute: Double
    let longitude: Double
    let data: String
    let descriacao: String
    let fotos:[UIImage]
    
    init(_ title: String, _ typeDen: Int, _ latitute: Double, _ longitude: Double, _ data: String, _ descricao: String, _ fotos: [UIImage]) {
        self.title = title
        self.typeDen = typeDen
        self.latitute = latitute
        self.longitude = longitude
        self.data = data
        self.descriacao = descricao
        self.fotos = fotos
    }
    
    
    static var mockDens: [Den] = [
        Den("Incendio", 1, -18.891421, -48.262694, "12/12/2017", "", [#imageLiteral(resourceName: "TitleDenApp2"),#imageLiteral(resourceName: "iconCamera"),#imageLiteral(resourceName: "backgroundLogin")]),
        Den("Assalto", 2,-18.892558, -48.268230, "13/12/2017", "321231234", [#imageLiteral(resourceName: "iconCrime"),#imageLiteral(resourceName: "iconCamera"),#imageLiteral(resourceName: "iconFire")]),
        Den( "Fogo",  1,-18.902558, -48.308230, "14/12/2017", "fghjrthk4", [#imageLiteral(resourceName: "iconWildAnimals"),#imageLiteral(resourceName: "backgroundLogin")]),
        Den( "Dali na pista",  4,-18.352558, -48.108230, "15/12/2017", "qqqaaaaa", [#imageLiteral(resourceName: "denAppLogo"),#imageLiteral(resourceName: "iconCamera"),#imageLiteral(resourceName: "backgroundLogin")]),
        Den( "Outro Dali na Pista", 4,-18.891558, -48.214230, "16/12/2017", "vvvvvvvv", [#imageLiteral(resourceName: "Image"),#imageLiteral(resourceName: "iconCamera"),#imageLiteral(resourceName: "backgroundLogin")]),
        Den( "Acidente",  3,-18.252558, -48.278230, "17/12/2017", "44545454", [#imageLiteral(resourceName: "iconFacebook"),#imageLiteral(resourceName: "iconCrime-1"),#imageLiteral(resourceName: "iconGoogle")]),
        Den( "Roubo na Loja", 3,-18.052558, -48.278230, "18/12/2017", "mmmmmmmmm", [#imageLiteral(resourceName: "iconIOS"),#imageLiteral(resourceName: "iconCamera")])
    ]
    
}


