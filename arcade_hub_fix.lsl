// Ultimate Arcade Hub Script (No-Bar Fix)
// Created by Gemini

integer FACE_NUMBER = 0;
string MAIN_URL = "https://selami79.github.io/weboyun/";

default
{
    state_entry()
    {
        // 1. Önce temizlik yapalım (Eski ayarlar kalmasın)
        llClearPrimMedia(FACE_NUMBER);
        
        // 2. Yeni ayarları "Sıfırdan" uygulayalım
        llSetPrimMediaParams(FACE_NUMBER, [
            PRIM_MEDIA_AUTO_PLAY, TRUE,
            PRIM_MEDIA_CURRENT_URL, MAIN_URL,
            PRIM_MEDIA_HOME_URL, MAIN_URL,
            PRIM_MEDIA_HEIGHT_PIXELS, 1024,
            PRIM_MEDIA_WIDTH_PIXELS, 1024,
            
            // CAN ALICI KISIM: Adres çubuğunu yok (GİZLİ) yapmak için:
            // Kontrol yetkisini "HİÇ KİMSE" (NONE) yapıyoruz.
            // Bu sayede bar hiç çizilmemeli.
            PRIM_MEDIA_PERMS_CONTROL, PRIM_MEDIA_PERM_NONE,
            
            // Ama etkileşimi (tıklamayı) HERKESE açıyoruz.
            PRIM_MEDIA_PERMS_INTERACT, PRIM_MEDIA_PERM_ANYONE,
            
            // İlk tıklamada direkt etkileşim olsun (Focus gerektirmesin)
            PRIM_MEDIA_FIRST_CLICK_INTERACT, TRUE,
            
            PRIM_MEDIA_AUTO_SCALE, FALSE,
            PRIM_MEDIA_AUTO_ZOOM, FALSE
        ]);
        
        llSetText("", <0,0,0>, 0);
        llSay(0, "Media Ayarlari SIFIRLANDI ve Guncellendi. Adres cubugu gizlendi.");
    }
}
