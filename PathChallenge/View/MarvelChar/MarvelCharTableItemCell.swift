//
//  MarvelCharTableItemCell.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//

import Foundation
import UIKit
import SDWebImage
import RxSwift
import RxGesture
import RxCocoa


class MarvelCharTableItemCell : PCUITableViewCell<MarvelCharDto> {
    var cellDelegate: MarvelCharTableItemCellDelegate?
    var index: Int?
    private lazy var cellView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = Color.white
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.build(textColor: Color.black, numberOfLines: 2,font: Font.QuickSand.semibold.getFont(with: 18), aligment: .left, text: "")
        return label
    }()
    
    private lazy var charImage: UIImageView = {
        let imageView = UIImageView()
      
        return imageView
    }()
    
    private lazy var arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "outline_arrow_forward_ios_black_36pt")
        imageView.tintColor = Color.divider
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var spaceView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.divider
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        self.rx
            .tapGesture()
            .when(.recognized)
            .subscribe({ _ in
                self.cellDelegate?.click(index: self.index ?? 0)
                
            })
            .disposed(by: self.disposeBag)
        
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initialize()
    }
    
    
    
    func initialize() {
        backgroundColor = Color.white
        addSubviews(self.cellView)
        self.cellView.addSubviews(self.titleLabel,self.charImage,self.arrowImage,self.spaceView)
        setupLayouts()
    }
    
    func setupLayouts() {
        cellView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(8)
            $0.top.equalToSuperview().offset(8)
            $0.right.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(10)
            
        }
        charImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.equalTo(60)
            $0.height.equalTo(60)
            $0.left.equalToSuperview().offset(8)
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalTo(spaceView.snp.top).offset(-8)
        }
        arrowImage.snp.makeConstraints {
            $0.centerY.equalTo(charImage)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
            $0.right.equalToSuperview().inset(8)
            
        }
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(charImage.snp.right).offset(8)
            $0.centerY.equalTo(charImage)
            $0.right.equalTo(arrowImage.snp.left).inset(8)
            
        }
        spaceView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(2)
            $0.right.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.height.equalTo(1)
            
        }
        
    }
    
    override func bind(item: MarvelCharDto) {
        self.titleLabel.text = item.name
        self.charImage.sd_setImage(with: URL(string: (item.thumbnail?.path ?? "") + "/standard_large." + (item.thumbnail?.ext ?? "")),placeholderImage: #imageLiteral(resourceName: "marvelph"),completed: {
            (image, error, cacheType, url) in
            self.charImage.makeRounded()
        })
    }
}
protocol MarvelCharTableItemCellDelegate {
    func click(index: Int)
}
