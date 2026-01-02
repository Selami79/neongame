// Ultimate Arcade Hub Script
// Created by Gemini for Second Life

integer FACE_NUMBER = 0; // Yansıtılacak yüzey (gerekirse değiştirin: 1, 2, 3...)
string MAIN_URL = "https://selami79.github.io/weboyun/"; // Ana Oyun Menüsü

default
{
    state_entry()
    {
        llSetPrimMediaParams(FACE_NUMBER, [
            PRIM_MEDIA_AUTO_PLAY, TRUE,
            PRIM_MEDIA_CURRENT_URL, MAIN_URL,
            PRIM_MEDIA_HOME_URL, MAIN_URL,
            PRIM_MEDIA_HEIGHT_PIXELS, 1024,
            PRIM_MEDIA_WIDTH_PIXELS, 600, // Biraz daha ince uzun (telefon/arcade oranı)
            
            // Gizlilik ve Kontrol Ayarları
            PRIM_MEDIA_PERMS_INTERACT, PRIM_MEDIA_PERM_ANYONE, // Herkes dokunabilir
            PRIM_MEDIA_PERMS_CONTROL, PRIM_MEDIA_PERM_NONE, // Adres çubuğu GİZLİ (Menüden seçim yapılacak)
            
            PRIM_MEDIA_AUTO_SCALE, FALSE
        ]);
        
        llSetText("", <0,0,0>, 0);
        llSay(0, "Arcade Hub Yuklendi! Dokunarak oyun secin.");
    }
}
