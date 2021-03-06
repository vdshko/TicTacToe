// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {

  public enum Alert {
    public enum Button {
      /// Restart game
      public static let restart = L10n.tr("Localizable", "alert.button.restart")
    }
    public enum Title {
      /// The game end with draw!
      public static let draw = L10n.tr("Localizable", "alert.title.draw")
      /// %@ - win the game!
      public static func win(_ p1: Any) -> String {
        return L10n.tr("Localizable", "alert.title.win", String(describing: p1))
      }
    }
  }

  public enum App {
    /// Tic Tac Toe
    public static let title = L10n.tr("Localizable", "app.title")
  }

  public enum Player {
    /// Computer
    public static let computer = L10n.tr("Localizable", "player.computer")
    /// Player 1
    public static let first = L10n.tr("Localizable", "player.first")
    /// Player 2
    public static let second = L10n.tr("Localizable", "player.second")
  }

  public enum Profile {
    public enum GameType {
      /// Multiplayer
      public static let multiPlayer = L10n.tr("Localizable", "profile.gameType.multiPlayer")
      /// Single player 
      public static let singlePlayer = L10n.tr("Localizable", "profile.gameType.singlePlayer")
    }
    public enum List {
      /// Game type
      public static let gameType = L10n.tr("Localizable", "profile.list.gameType")
      /// Restart game
      public static let restart = L10n.tr("Localizable", "profile.list.restart")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
