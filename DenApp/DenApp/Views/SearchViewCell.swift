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
    let key: String
    var fotos:[UIImage]
    
    init(_ title: String, _ typeDen: Int, _ latitute: Double, _ longitude: Double, _ data: String, _ descricao: String, _ fotos: [UIImage], _ key: String) {
        self.title = title
        self.typeDen = typeDen
        self.latitute = latitute
        self.longitude = longitude
        self.data = data
        self.descriacao = descricao
        self.fotos = fotos
        self.key = key
        
    }
    
    
  
}


