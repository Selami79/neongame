// HEXTRIS NEON - Second Life Ultimate Script with Auto-Detect Player Name
// Created by Gemini for Selami

integer FACE_NUMBER = 2;
string GAME_BASE_URL = "https://selami79.github.io/weboyun/index.html";
string my_url = "";
string current_player_name = ""; // Dokunan son oyuncunun ismi

// High Score Data
list highScores = []; 
integer MAX_SCORES = 10;

UpdateHighScores(string name, integer score)
{
    highScores += [score, name];
    highScores = llListSort(highScores, 2, FALSE); // Sort Descending
    
    if(llGetListLength(highScores) > MAX_SCORES * 2) {
        highScores = llList2List(highScores, 0, (MAX_SCORES * 2) - 1);
    }
    
    DisplayHighScores();
}

DisplayHighScores()
{
    string text = "🏆 NEON HEX TOP 10 🏆\n\n";
    integer len = llGetListLength(highScores);
    integer i;
    for(i=0; i<len; i+=2) {
        integer score = llList2Integer(highScores, i);
        string name = llList2String(highScores, i+1);
        text += (string)((i/2)+1) + ". " + name + " - " + (string)score + "\n";
    }
    
    llSetText(text, <0,1,1>, 1.0);
}

// Oyuncu ismine gore URL olustur ve yukle
LoadGameForPlayer(string player_name)
{
    // URL format: index.html?sl_url=...&player=AvatarName
    string final_url = GAME_BASE_URL + "?sl_url=" + llEscapeURL(my_url) + "&player=" + llEscapeURL(player_name);
    
    // Sadece URL'yi guncelle
    llSetPrimMediaParams(FACE_NUMBER, [
        PRIM_MEDIA_CURRENT_URL, final_url
    ]);
}

SetupMediaBase()
{
    llClearPrimMedia(FACE_NUMBER);
    // Baslangic URL'si (Oyuncu ismi yok)
    string base_url = GAME_BASE_URL + "?sl_url=" + llEscapeURL(my_url);
    
    llSetPrimMediaParams(FACE_NUMBER, [
        PRIM_MEDIA_AUTO_PLAY, TRUE,
        PRIM_MEDIA_CURRENT_URL, base_url,
        PRIM_MEDIA_HOME_URL, base_url,
        PRIM_MEDIA_HEIGHT_PIXELS, 1024,
        PRIM_MEDIA_WIDTH_PIXELS, 1024,
        PRIM_MEDIA_PERMS_CONTROL, PRIM_MEDIA_PERM_NONE,
        PRIM_MEDIA_PERMS_INTERACT, PRIM_MEDIA_PERM_ANYONE,
        PRIM_MEDIA_FIRST_CLICK_INTERACT, TRUE,
        PRIM_MEDIA_AUTO_SCALE, FALSE,
        PRIM_MEDIA_AUTO_ZOOM, FALSE
    ]);
}

default
{
    state_entry()
    {
        llRequestURL();
    }

    http_request(key id, string method, string body)
    {
        if (method == URL_REQUEST_GRANTED)
        {
            my_url = body;
            llOwnerSay("URL Created. System Ready.");
            SetupMediaBase();
        }
        else if (method == "POST")
        {
            string name = llJsonGetValue(body, ["name"]); // Web'den gelen isim (URL'den gitmisti zaten)
            string score_str = llJsonGetValue(body, ["score"]);
            integer score = (integer)score_str;
            
            if(name != JSON_INVALID && score_str != JSON_INVALID) {
                UpdateHighScores(name, score);
                llHTTPResponse(id, 200, "OK");
                llSay(0, "New High Score! " + name + ": " + (string)score);
            }
        }
    }
    
    touch_start(integer total_number)
    {
        // Dokunan kisinin ismini al
        string new_player = llDetectedName(0);
        
        string touchedPrimName = llGetLinkName(llDetectedLinkNumber(0));
        
        if (touchedPrimName == "reset")
        {
            llRequestURL();
        }
        else
        {
            // Eger farkli bir oyuncu dokundusa sayfayi onun ismine gore yenile
            if(new_player != current_player_name)
            {
                current_player_name = new_player;
                llSay(0, "Hosgeldin " + current_player_name + "! Oyun senin icin yukleniyor...");
                LoadGameForPlayer(current_player_name);
            }
        }
    }
    
    on_rez(integer start_param) { llResetScript(); }
    changed(integer change) { if(change & CHANGED_REGION) llRequestURL(); }
}
