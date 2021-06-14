//
//  DestinationUIView.swift
//  ptuBus
//
//  Created by rokong.me on 2021/06/13.
//

import UIKit

protocol DestinationViewDelegate {
    func clickSearchButton()
    
}

@IBDesignable
class DestinationUIView: UIView {
    
    public var delegate:DestinationViewDelegate?
    
    @IBOutlet var selectTimeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit(){
        let bundle = Bundle.init(for: self.classForCoder)
        let view = bundle.loadNibNamed("DestinationView",
                                       owner: self,
                                       options: nil)?.first as! UIView
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(rgb: 0xaaaaaa).cgColor
        view.layer.cornerRadius = 10
        view.frame = self.bounds
        
        let time = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy년 MM월 dd일 (E) HH:mm"
        let stringDate = timeFormatter.string(from: time)
        self.selectTimeLabel.text = stringDate
        
        
        self.addSubview(view)
    }
    
    @IBAction func clickedsearchButton(_ sender: Any) {
        self.delegate?.clickSearchButton()
    }
    
}

