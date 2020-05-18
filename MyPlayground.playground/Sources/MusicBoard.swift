import UIKit
import AVFoundation

public class MusicBoard: UIViewController {
    
    public var wallpapersImageNames = [String]()
    public var currentRandomWallpaper = ""
    public var mainBG: UIImageView!
    public var blurredView: UIView!
    public var logoImageView: UIImageView!
    public var descriptionImageView: UIImageView!
    public var player: AVAudioPlayer?
    public var backButton: UIButton!
    
    public var delegate: BackButtonProtocol?
    
    public var detailTitleLabel: UILabel!
    public var detailImageView: UIImageView!
    public var creditLabel: UILabel!
    public var detailDescription: UILabel!
    public var playButton: UIButton!
    
    var isPlayingMusic = false
    var isMusicAlreadyPlayed = false
    var sampleMusicPlayer: AVAudioPlayer?
    public var musicFile: String!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray

        self.view.addSubview(mainBG)
        self.view.addSubview(blurredView)
        self.view.addSubview(logoImageView)
        self.view.addSubview(descriptionImageView)
        
        self.backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 32, y: 35, width: 20, height: 30)
        backButton.setImage(UIImage(named: "back3x"), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        player!.setVolume(0, fadeDuration: 1)
  
        self.detailTitleLabel.font = UIFont(name: "MarkerFelt-Thin", size: 30)
        self.detailTitleLabel.frame = CGRect(x: 50, y: 150, width: 500, height: 35)
        self.detailTitleLabel.textColor = .white
        self.detailTitleLabel.textAlignment = .center
        view.addSubview(detailTitleLabel)
        
        self.detailImageView.contentMode = .scaleAspectFit
        self.detailImageView.frame = CGRect(x: 50, y: 190, width: 500, height: 200)
        view.addSubview(detailImageView)
        
        self.creditLabel.frame = CGRect(x: 32, y: 400, width: 538, height: 11)
        self.creditLabel.textColor = .white
        self.creditLabel.textAlignment = .center
        self.creditLabel.adjustsFontSizeToFitWidth = true
        self.creditLabel.font = UIFont.systemFont(ofSize: 9, weight: .regular)
        self.view.addSubview(creditLabel)
        
        self.playButton = UIButton(type: .system)
        self.playButton.frame = CGRect(x: 260, y: 415, width: 80, height: 80)
        playButton.setImage(UIImage(named: "play2"), for: .normal)
        playButton.tintColor = .white
        self.view.addSubview(self.playButton)
        
        self.playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        
        self.detailDescription.frame = CGRect(x: 32, y: 500, width:538,  height: 100)

        self.detailDescription.adjustsFontSizeToFitWidth = true
        self.detailDescription.textColor = .white
        self.detailDescription.numberOfLines = 0
        self.detailDescription.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        self.view.addSubview(detailDescription)
        print(detailDescription.frame.size.height)
        
        self.detailImageView.alpha = 0
        self.detailTitleLabel.alpha = 0
        self.creditLabel.alpha = 0
        self.detailDescription.alpha = 0
        self.playButton.alpha = 0
        
        self.backButton.alpha = 0
        UIView.animate(withDuration: 0.7) {
            self.blurredView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
            self.backButton.alpha = 1
            self.detailImageView.alpha = 1
            self.detailTitleLabel.alpha = 1
            self.creditLabel.alpha = 1
            self.detailDescription.alpha = 1
            self.playButton.alpha = 1
        }
    }
    
    @objc
    func backButtonTapped(){
        delegate!.backButtonPressed(currentWallpaper: self.currentRandomWallpaper, wallpapers: self.wallpapersImageNames, mainBg: self.mainBG, blurredView: self.blurredView, logoImageView: self.logoImageView, descriptionImageView: self.descriptionImageView, player: self.player!)
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc
    func playButtonTapped(){
        if self.isPlayingMusic == false {
            print("Playing")
            self.playButton.setImage(UIImage(named: "pause2"), for: .normal)
            if isMusicAlreadyPlayed ==  false {
                playSound()
            } else {
                self.sampleMusicPlayer?.play()
            }
        } else {
            print("Paused")
            self.playButton.setImage(UIImage(named: "play2"), for: .normal)
            self.sampleMusicPlayer!.pause()
        }
        self.isPlayingMusic = !self.isPlayingMusic
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: self.musicFile!, withExtension: "m4a")!
        do {
            self.sampleMusicPlayer = try AVAudioPlayer(contentsOf: url)
//            guard let player2 = sampleMusicPlayer else { return }
            sampleMusicPlayer!.prepareToPlay()
            sampleMusicPlayer!.numberOfLoops = -1
            sampleMusicPlayer!.play()
            self.isMusicAlreadyPlayed = true
        } catch {
            
        }
    }
}
