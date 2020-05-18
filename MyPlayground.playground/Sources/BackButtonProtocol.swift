import UIKit
import AVFoundation

public protocol BackButtonProtocol {
    func backButtonPressed(currentWallpaper: String, wallpapers: [String], mainBg: UIImageView, blurredView: UIView, logoImageView: UIImageView, descriptionImageView: UIImageView, player: AVAudioPlayer)
}
