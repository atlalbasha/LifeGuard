//
//  FirstAidList.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-04-25.
//

import Foundation
import UIKit



struct FirstAidBrain {
    
    
    
 
    
   let title = "First Aid Guide"
   let image = UIImage(systemName: "cross")
    
    let countAid = [1,2,3,4, 5,6,7,8,9]
    
     let LABC = [
        
    
        
        FirstAidModel(name: "L-ABCDE", describe: """
L-ABCDE

L – Livsfarligt läge

A – Airway and cervical spine control

B – Breathing

C – Circulation and bleeding

D – Disability

E – Expose and protect from the environment

Larma 112 tidigt vid behov.
""", image: UIImage(named: "drunkning")),
        
  
        
    ]
    
    let firstAid = [
       
       FirstAidModel(name: "Barn HLR", describe: "Barn HLR", image: UIImage(named: "Handlingsplan-Barn-HLR")),
        
        FirstAidModel(name: "Vuxen HLR", describe: "Vuxen HLR", image: UIImage(named: "Handlingsplan-Vuxen-HLR-2016")),
        
       FirstAidModel(name: "HLR vid drunkning", describe: "HLR vid drunkning", image: UIImage(named: "Handlingsplan-HLR-vid-drunkning-2016")),
        
       FirstAidModel(name: "Luftvägsstopp", describe: "luftvägsstopp", image: UIImage(named: "Handlingsplan-luftvägsstopp-2016")),
        
        
       
   ]
    
    let phone = [
        
    
        FirstAidModel(name: "ALarm", describe: "112", image: UIImage(systemName: "phone")),
        
        FirstAidModel(name: "Atlal Basha", describe: "0722759577", image: UIImage(systemName: "phone"))
    ]
    
}


