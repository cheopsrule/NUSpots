//
//  FavoritesViewController.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/21/21.
//

import UIKit
import CollapsibleTableSectionViewController

class FavoritesViewController: ListedSpacesViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Get the filtered favorites list
        let buildings = DataSingleton.sharedInstance.buildings
        var filtered: [Building] = []
        for b in buildings {
            let f = b.filterSpaces(predicate: { DataSingleton.sharedInstance.favoriteSpaces.contains($0.s_id) })
            if f != nil { filtered.append(f!) }
        }
        self.buildings = filtered
        self.tableView.reloadData() // reload table data
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let spaceVC = segue.destination as? SpaceViewController {
            let buildingSpace = sender as! (Building, Space)
            spaceVC.building = buildingSpace.0 // set building
            spaceVC.space = buildingSpace.1 // set space
        }
    }
    
    // Select a row
    func collapsibleTableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let space = buildings[indexPath.section].spaces[indexPath.row] // Space that was selected
        let building = buildings[indexPath.section]
        performSegue(withIdentifier: "fave-to-space", sender: (building, space))
    }
}
