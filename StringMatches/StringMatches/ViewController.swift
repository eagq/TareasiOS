//
//  ViewController.swift
//  StringMatches
//
//  Created by Edgar Gaytán on 2/5/18.
//  Copyright © 2018 Edgar Gaytán. All rights reserved.
//

import UIKit
import Fuse

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    let array = ["Harry Truman", "Doris Ray", "Johnnie Ray", "Walter Winchell", "Joe DiMaggio", "Joe McCarthy", "Richard Nixon", "Marilyn Monroe", "Dwight D. Eisenhower", "Rocky Marciano", "Marlon Brando", "Joseph Stalin", "Georgy Malenkov", "Gamal Abdel Nasser", "Sergei Prokofiev", "John D. Rockefeller", "Roy Campanella", "Roy Cohn", "Juan Perón", "Arturo Toscanini", "Albert Einstein", "James Dean", "Davy Crockett", "Elvis Presley", "Brigitte Bardot", "Nikita Khrushchev", "Grace Kelly", "Boris Pasternak", "Mickey Mantle", "Jack Kerouac", "Charles de Gaulle", "Charles Starkweather", "Fidel Castro", "Syngman Rhee", "John F. Kennedy", "Ernest Hemingway", "Bob Dylan", "Ronald Reagan", "Sally Ride", "Bernie Goetz"]
    var aux = [String]()
    var reset: Bool = false
    let fuse = Fuse()
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var TextBox: UITextField!
    @IBOutlet weak var SearchButton: UIButton!
    @IBOutlet weak var ResetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !reset{
            return array.count
        }
        else{
            return aux.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !reset{
            return "Names"
        }
        else{
            return "Matches"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "IdCelda", for: indexPath)
        let i = indexPath.row
        if !reset{
            cell.textLabel?.text = "\(array[i])"
        }
        else{
            cell.textLabel?.text = "\(aux[i])"
        }
        return cell
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        aux = [String]()
        var input: String = TextBox.text!
        input = input.lowercased()
        
        for name in array{
            let res = fuse.search(input, in: name.lowercased())
            if  res?.score != nil{
                if (res?.score.isLessThanOrEqualTo(0.35))!{
                    aux.append(name)
                }
            }
        }
        reset = true
        TableView.reloadData()
    }
    
    @IBAction func resetButtonClicked(_ sender: UIButton) {
        reset = false
        aux = [String]()
        TableView.reloadData()
        TextBox.text = ""
    }
    
}

