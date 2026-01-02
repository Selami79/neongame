// Ultimate Arcade Hub Script with Reset Button
// Created by Gemini for Second Life

integer FACE_NUMBER = 0; // Media yüzeyi (Root prim üzerindeki yüzey)
string MAIN_URL = "https://selami79.github.io/weboyun/";

// Resetleme Fonksiyonu
ResetMedia()
{
    llSetPrimMediaParams(FACE_NUMBER, [
        PRIM_MEDIA_CURRENT_URL, MAIN_URL // Sadece URL'yi ana sayfaya döndür
    ]);
    llSay(0, "Ekran Ana Menuye Dondu.");
}

default
{
    state_entry()
    {
        // Başlangıç Ayarları (Adres çubuğu gizli)
        llClearPrimMedia(FACE_NUMBER);
        llSetPrimMediaParams(FACE_NUMBER, [
            PRIM_MEDIA_AUTO_PLAY, TRUE,
            PRIM_MEDIA_CURRENT_URL, MAIN_URL,
            PRIM_MEDIA_HOME_URL, MAIN_URL,
            PRIM_MEDIA_HEIGHT_PIXELS, 1024,
            PRIM_MEDIA_WIDTH_PIXELS, 1024,
            PRIM_MEDIA_PERMS_CONTROL, PRIM_MEDIA_PERM_NONE, // Bar yok
            PRIM_MEDIA_PERMS_INTERACT, PRIM_MEDIA_PERM_ANYONE,
            PRIM_MEDIA_FIRST_CLICK_INTERACT, TRUE,
            PRIM_MEDIA_AUTO_SCALE, FALSE,
            PRIM_MEDIA_AUTO_ZOOM, FALSE
        ]);
        
        llSetText("", <0,0,0>, 0);
        llSay(0, "Sistem Hazir. 'reset' isimli butona basarak ana menuye onebilirsiniz.");
    }

    touch_start(integer total_number)
    {
        integer i;
        for(i=0; i<total_number; ++i)
        {
            // Dokunulan primin (objenin) ismini al
            string touchedPrimName = llGetLinkName(llDetectedLinkNumber(i));
            
            // Eğer ismi "reset" ise (küçük harfe dikkat)
            if (touchedPrimName == "reset")
            {
                ResetMedia();
            }
        }
    }
}
