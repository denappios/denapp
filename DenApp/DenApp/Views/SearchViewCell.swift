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
    
    init(_ title: String, _ typeDen: Int) {
        self.title = title
        self.typeDen = typeDen
    }
    
    
    static var mockDens: [Den] = [
        Den("Incendio", 1),Den("Assalto", 2),Den( "Fogo",  1),Den( "Dali na pista",  4),Den( "Outro Dali na Pista", 4),Den( "Acidente",  3),Den( "Roubo na Loja", 3)
    ]
    
}


