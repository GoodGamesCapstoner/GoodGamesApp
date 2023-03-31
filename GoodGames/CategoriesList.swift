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
    case co_op = "Co-Op"
    case commentary_available = "Commentary-Available"
    case cross_platform_multiplayer = "Cross-Platform-Multiplayer"
    case in_app_purchases = "In-App-Purchases"
    case lan_co_op = "LAN-Co-Op"
    case lan_pvp = "LAN-PvP"
    case mods = "Mods"
    case multi_player = "Multi-player"
    case mmo = "MMO"
    case online_co_op = "Online-Co-Op"
    case online_pvp = "Online-PvP"
    case partial_controller_support = "Partial-Controller-Support"
    case pvp = "PvP"
    case remote = "Remote"
    case remote_play_on_phone = "Remote-Play-On-Phone"
    case remote_play_on_tablet = "Remote-Play-on-Tablet"
    case remote_play_on_tv = "Remote-Play-on-TV"
    case shared_split_screen = "Shared/Split-Screen"
    case shared_split_screen_pvp = "Shared/Split-Screen-PvP"
    case steam_achievements = "Steam-Achievements"
    case steam_trading_cards = "Steam-Trading-Cards"
    case steam_turn_notifications = "Steam-Turn-Notifications"
    case steam_workshop = "Steam-Workshop"
    case steam_leaderboards = "Steam-Leaderboards"
    case steamvr_collectibles = "SteamVR-Collectibles"
    case tracked_controller_support = "Tracked-Controller-Support"
    case vr_only = "VR-Only"
    case vr_supported = "VR-Supported"
}
