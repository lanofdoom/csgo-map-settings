#include <sourcemod>

ConVar g_game_type;
ConVar g_game_mode;
ConVar g_skirmish_id;

public const Plugin myinfo = {
    name = "Map Settings", author = "LAN of DOOM",
    description = "Sets map settings preferred by the LAN of DOOM",
    version = "1.0.0",
    url = "https://github.com/lanofdoom/csgo-map-settings"};

//
// Logic
//

static void UpdateGameMode() {
  char map_name[PLATFORM_MAX_PATH];
  GetCurrentMap(map_name, PLATFORM_MAX_PATH);

  if (StrContains(map_name, "ar_") == 0) {
    g_game_type.IntValue = 6;
    g_game_mode.IntValue = 0;
    g_skirmish_id.IntValue = 10;
  } else if (StrContains(map_name, "dz_") == 0) {
    g_game_type.IntValue = 6;
    g_game_mode.IntValue = 0;
    g_skirmish_id.IntValue = 0;
  } else if (StrContains(map_name, "gd_") == 0) {
    g_game_type.IntValue = 4;
    g_game_mode.IntValue = 0;
    g_skirmish_id.IntValue = 0;
  } else if (strlen(map_name) != 0) {
    g_game_type.IntValue = 0;
    g_game_mode.IntValue = 0;
    g_skirmish_id.IntValue = 0;    
  }
}

//
// Forwards
//

public void OnMapStart() {
  UpdateGameMode();
}

public void OnPluginStart() {
  g_game_type = FindConVar("game_type");
  g_game_mode = FindConVar("game_mode");
  g_skirmish_id = FindConVar("sv_skirmish_id");
  UpdateGameMode();
}