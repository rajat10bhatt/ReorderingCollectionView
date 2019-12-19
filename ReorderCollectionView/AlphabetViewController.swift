//
//  ViewController.swift
//  ReorderCollectionView
//
//  Created by Rajat Bhatt on 19/12/19.
//  Copyright © 2019 Rajat Bhatt. All rights reserved.
//

import UIKit

class AlphabetViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var alphabet: [[String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let str: String = "ABC"
        let str1: String = "DEFGHIJKLMNOPQRSTUVWXYZ"
        var array: [String] = []

        for i in str {
            array.append(String(i))
        }
        alphabet.append(array)
        array.removeAll()
        for i in str1 {
            array.append(String(i))
        }
        alphabet.append(array)
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.actionAfterLongPress(gesture:)))
        collectionView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func actionAfterLongPress(gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
}

extension AlphabetViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return alphabet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alphabet[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AlphabetCollectionViewCell

        // Configure the cell
        cell.alphabetLabel.text = alphabet[indexPath.section][indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = alphabet[sourceIndexPath.section].remove(at: sourceIndexPath.item)
        alphabet[destinationIndexPath.section].insert(temp, at: destinationIndexPath.item)
    }
}

extension AlphabetViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        print(alphabet)
    }
}


