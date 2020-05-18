import UIKit
import AVFoundation

public class ListDetailBoard: UIViewController  {
    public var wallpapersImageNames = [String]()
    public var currentRandomWallpaper = ""
    
    public var mainBG: UIImageView!
    public var blurredView: UIView!
    public var logoImageView: UIImageView!
    public var descriptionImageView: UIImageView!
    public var player: AVAudioPlayer?
    public var backButton: UIButton!

    public var delegate: BackButtonProtocol?
    
    public var selectedItem: Int!
    
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
        
        self.backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 32, y: 35, width: 20, height: 30)
        backButton.setImage(UIImage(named: "back3x"), for: .normal)
        backButton.tintColor = .white
        self.view.addSubview(backButton)
        self.backButton.alpha = 0
        self.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        UIView.animate(withDuration: 0.7) {
            self.listBoardCollectionView.alpha = 1
            self.backButton.alpha = 1
            self.logoImageView.frame = CGRect(x: 235, y: 30, width: 130, height: 40)
            self.descriptionImageView.frame = CGRect(x: 220, y: 75, width: 160, height: 20)
            self.listBoardCollectionView.layoutIfNeeded()
            self.logoImageView.layoutIfNeeded()
        }
    }
    
    @objc
    func nextButtonTapped(row: Int){
        view.addSubview(backButton)
        if self.selectedItem == 1 {
            let musicBoard = MusicBoard()
            musicBoard.currentRandomWallpaper = self.currentRandomWallpaper
            musicBoard.wallpapersImageNames = self.wallpapersImageNames
            musicBoard.mainBG = self.mainBG
            musicBoard.blurredView = self.blurredView
            musicBoard.logoImageView = self.logoImageView
            musicBoard.descriptionImageView = self.descriptionImageView
            musicBoard.player = self.player
            
            musicBoard.detailImageView = UIImageView(image: UIImage(named: MusicListData.listImage[row]))
            musicBoard.detailTitleLabel = UILabel()
            musicBoard.detailTitleLabel.text = MusicListData.listTitle[row]
            
            musicBoard.creditLabel = UILabel()
            musicBoard.creditLabel.text = MusicListData.source[row]
            
            musicBoard.detailDescription = UILabel()
            musicBoard.detailDescription.text = MusicListData.desriptions[row]
            musicBoard.musicFile = MusicListData.file[row]
            
            musicBoard.delegate = self
            navigationController?.pushViewController(musicBoard, animated: false)
        } else {
            let detailBoard = DetailBoard()
            
            detailBoard.currentRandomWallpaper = self.currentRandomWallpaper
            detailBoard.wallpapersImageNames = self.wallpapersImageNames
            detailBoard.mainBG = self.mainBG
            detailBoard.blurredView = self.blurredView
            detailBoard.logoImageView = self.logoImageView
            
            detailBoard.descriptionImageView = self.descriptionImageView
            detailBoard.player = self.player
            detailBoard.delegate = self
            
            if self.selectedItem == 0 {
                detailBoard.detailImageView = UIImageView(image: UIImage(named: AttractionListData.listImage[row]))
                detailBoard.detailTitleLabel = UILabel()
                detailBoard.detailTitleLabel.text = AttractionListData.listTitle[row]
                
                detailBoard.creditLabel = UILabel()
                detailBoard.creditLabel.text = AttractionListData.source[row]
                
                detailBoard.detailDescription = UILabel()
                detailBoard.detailDescription.text = AttractionListData.desriptions[row]
            } else if self.selectedItem == 2 {
                detailBoard.detailImageView = UIImageView(image: UIImage(named: FoodListData.listImage[row]))
                detailBoard.detailTitleLabel = UILabel()
                detailBoard.detailTitleLabel.text = FoodListData.listTitle[row]
                
                detailBoard.creditLabel = UILabel()
                detailBoard.creditLabel.text = FoodListData.source[row]
                
                detailBoard.detailDescription = UILabel()
                detailBoard.detailDescription.text = FoodListData.desriptions[row]
            } else if self.selectedItem == 3 {
                detailBoard.detailImageView = UIImageView(image: UIImage(named: AnimalListData.listImage[row]))
                detailBoard.detailTitleLabel = UILabel()
                detailBoard.detailTitleLabel.text = AnimalListData.listTitle[row]
                
                detailBoard.creditLabel = UILabel()
                detailBoard.creditLabel.text = AnimalListData.source[row]
                
                detailBoard.detailDescription = UILabel()
                detailBoard.detailDescription.text = AnimalListData.desriptions[row]
            }
            
            navigationController?.pushViewController(detailBoard, animated: false)
        }
       
    }
    
    @objc
    func backButtonTapped(){
        delegate!.backButtonPressed(currentWallpaper: self.currentRandomWallpaper, wallpapers: self.wallpapersImageNames, mainBg: self.mainBG, blurredView: self.blurredView, logoImageView: self.logoImageView, descriptionImageView: self.descriptionImageView, player: self.player!)
        self.navigationController?.popViewController(animated: false)
    }
}

extension ListDetailBoard: UICollectionViewDelegate, UICollectionViewDataSource, BackButtonProtocol {
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
        view.addSubview(backButton)
        
        listBoardCollectionView.alpha = 0
        backButton.alpha = 0
        UIView.animate(withDuration: 0.7) {
            self.listBoardCollectionView.alpha = 1
            self.backButton.alpha = 1
            self.blurredView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        }
        
        player.setVolume(1, fadeDuration: 2)
        player.play()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.selectedItem == 0 {
            return AttractionListData.listTitle.count
        } else if self.selectedItem == 1 {
            return MusicListData.listTitle.count
        } else if self.selectedItem == 2 {
            return FoodListData.listTitle.count
        } else {
            return AnimalListData.listTitle.count
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as! ListCell
        if self.selectedItem == 0 {
            cell.itemLabel.text = AttractionListData.listTitle[indexPath.row]
            cell.itemImageView.image = UIImage(named: AttractionListData.listImage[indexPath.row])
        } else if self.selectedItem == 1 {
            cell.itemLabel.text = MusicListData.listTitle[indexPath.row]
            cell.itemImageView.image = UIImage(named: MusicListData.listImage[indexPath.row])
        } else if self.selectedItem == 2 {
            cell.itemLabel.text = FoodListData.listTitle[indexPath.row]
            cell.itemImageView.image = UIImage(named: FoodListData.listImage[indexPath.row])
        } else {
            cell.itemLabel.text = AnimalListData.listTitle[indexPath.row]
            cell.itemImageView.image = UIImage(named: AnimalListData.listImage[indexPath.row])
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        nextButtonTapped(row: indexPath.row)
    }
}
