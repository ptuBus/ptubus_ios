//
//  TrainDestinationViewController.swift
//  ptuBus
//
//  Created by rokong.me on 2021/06/14.
//

import UIKit

class TrainDestinationViewController: UIViewController, DestinationViewDelegate {

    

    @IBOutlet var destinationView: DestinationUIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        self.destinationView.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TrainDestinationViewController {
    func clickSearchButton() {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let controller = story.instantiateViewController(identifier: "TrainViewController") as!
            TrainViewController
        let navigation = UINavigationController(rootViewController:controller)
        self.view.addSubview(navigation.view)
        self.addChild(navigation)
        navigation.didMove(toParent: self)
    }
}
