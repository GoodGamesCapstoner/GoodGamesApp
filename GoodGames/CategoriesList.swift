//
//  CategoriesList.swift
//  GoodGames
//
//  Created by Adriana Cottle on 3/28/23.
//
// ['Mods', 'LAN PvP', 'Tracked Controller Support', 'VR Only', 'Cross-Platform Multiplayer', 'Commentary available', 'Partial Controller Support', 'Remote Play on TV', 'SteamVR Collectibles', 'Co-op', 'Solo', 'Shared/Split Screen PvP', 'Full controller support', 'Valve Anti-Cheat enabled', 'Steam Turn Notifications', 'Steam Achievements', 'Shared/Split Screen', 'Online Co-op', 'Shared/Split Screen Co-op', 'Steam Workshop', 'Mods (require HL)', 'Multi-player', 'Stats', 'VR Support', 'Steam Cloud', 'Includes Source SDK', 'Steam Trading Cards', 'Single-player', 'VR Supported', 'Captions available', 'Remote Play on Tablet', 'Remote Play Together', 'Online PvP', 'MMO', 'Includes level editor', 'LAN Co-op', 'MMO', 'Co-op', 'Steam Achievements', 'Remote Play on Phone', 'In-App Purchases', 'Steam Leaderboards', 'PvP']

import Foundation

// double check this with the new data
enum GameCategory: String, CaseIterable {
    case captionsAvailable = "Captions available"
    case co_op = "Co-op"
    case crossPlatformMultipalyer = "Cross-Platform Multiplayer"
    case fullControllerSupport = "Full controller support"
    case includesLevelEditor = "Includes level editor"
    case includesSourceSDK = "Includes Source SDK"
    case in_AppPurchases = "In-App Purchases"
    case lanCo_op = "LAN Co-op"
    case lanPvp = "LAN PvP"
    case mmo = "MMO"
    case mods = "Mods"
    case modsRequireHl = "Mods (require HL)"
    case multi_player = "Multi-player"
    case onlineCo_op = "Online Co-op"
    case onlinePvp = "Online PvP"
    case partialControllerSupport = "Partial Controller Support"
    case pvp = "PvP"
    case remotePlayOnPhone = "Remote Play on Phone"
    case remotePlayOnTablet = "Remote Play on Tablet"
    case remotePlayOnTV = "Remote Play on TV"
    case remotePlayTogether = "Remote Play Together"
    case sharedSplitScreen = "Shared/Split Screen"
    case sharedSplitScreenCo_op = "Shared/Split Screen Co-op"
    case sharedSplitScreenPvp = "Shared/Split Screen PvP"
    case single_player = "Single-player"
    case solo = "Solo"
    case stats = "Stats"
    case steamAchievements = "Steam Achievements"
    case steamCloud = "SteamCloud"
    case steamLeaderboards = "Steam Leaderboards"
    case steamTradingCards = "Steam Trading Cards"
    case steamTurnNotifications = "Steam Turn Notifications"
    case steamVrCollectibles = "SteamVR Collectibles"
    case steamWorkshop = "Steam Workshop"
    case trackedControllerSupport = "Tracked Controller Support"
    case valveAntiCheatEnabled = "Valve Anti-Cheat enabled"
    case vrOnly = "VR Only"
    case vrSupport = "VR Support"
    case vrSupported = "VR Supported"
}
