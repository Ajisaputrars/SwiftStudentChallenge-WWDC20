import UIKit
import AVFoundation

public class ListBoard: UIViewController  {
    
    public var wallpapersImageNames = [String]()
    public var currentRandomWallpaper = ""
    
    public var mainBG: UIImageView!
    public var blurredView: UIView!
    public var logoImageView: UIImageView!
    public var descriptionImageView: UIImageView!
    public var player: AVAudioPlayer?
    
    let listBoardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 157, height: 200)
        
        let collectionView = UICollectionView(frame: CGRect(x: 50, y: 150, width: 500, height: 650), collectionViewLayout: layout)
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: "listCell")
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .clear 
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mainBG)
        view.addSubview(blurredView)
        view.addSubview(logoImageView)
        view.addSubview(descriptionImageView)
        
        view.addSubview(listBoardCollectionView)
        listBoardCollectionView.delegate = self
        listBoardCollectionView.dataSource = self
        
        self.listBoardCollectionView.alpha = 0
        
        UIView.animate(withDuration: 1) {
            self.listBoardCollectionView.alpha = 1
            self.logoImageView.frame = CGRect(x: 235, y: 30, width: 130, height: 40)
            self.descriptionImageView.frame = CGRect(x: 220, y: 75, width: 160, height: 20)
            self.listBoardCollectionView.layoutIfNeeded()
            self.logoImageView.layoutIfNeeded()
        }
    }
        
    @objc
    func nextButtonTapped(selectedItem: Int){
        let listDetailBoard = ListDetailBoard()
        listDetailBoard.currentRandomWallpaper = self.currentRandomWallpaper
        listDetailBoard.wallpapersImageNames = self.wallpapersImageNames
        listDetailBoard.mainBG = self.mainBG
        listDetailBoard.blurredView = self.blurredView
        listDetailBoard.logoImageView = self.logoImageView
        listDetailBoard.descriptionImageView = self.descriptionImageView
        listDetailBoard.player = self.player
        listDetailBoard.selectedItem = selectedItem
        
        listDetailBoard.delegate = self
                
        navigationController?.pushViewController(listDetailBoard, animated: false)
    }
}

extension ListBoard: UICollectionViewDelegate, UICollectionViewDataSource, BackButtonProtocol {
    public func backButtonPressed(currentWallpaper: String, wallpapers: [String], mainBg: UIImageView, blurredView: UIView, logoImageView: UIImageView, descriptionImageView: UIImageView, player: AVAudioPlayer) {
        self.currentRandomWallpaper = currentWallpaper
        self.wallpapersImageNames = wallpapers
        self.mainBG = mainBg
        self.blurredView = blurredView
        self.logoImageView = logoImageView
        self.descriptionImageView = descriptionImageView
        self.player = player
        
        view.addSubview(mainBG)
        view.addSubview(blurredView)
        view.addSubview(logoImageView)
        view.addSubview(descriptionImageView)
        
        listBoardCollectionView.removeFromSuperview()
        view.addSubview(listBoardCollectionView)
        
        listBoardCollectionView.alpha = 0
        UIView.animate(withDuration: 0.7) {
            self.listBoardCollectionView.alpha = 1
            self.blurredView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        }
        
        player.setVolume(1, fadeDuration: 2)
        player.play()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FrontListData.listTitle.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as! ListCell
        cell.itemLabel.text = FrontListData.listTitle[indexPath.row]
        cell.itemImageView.image = UIImage(named: FrontListData.listImage[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        nextButtonTapped(selectedItem: indexPath.row)
    }
}

