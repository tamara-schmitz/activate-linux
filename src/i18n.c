#include "i18n.h"
#include "i18n-helper.h"
#include "draw.h"
#include "log.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

// FIXME: You must follow the order of presets[] in i18n_map[]
static preset_map presets[] = {
    map_preset("mac",       "Platform preset for macOS")
    map_preset("bsd",       "Platform preset for *BSD")
    map_preset("linux",     "Platform preset for Linux")
    map_preset("hurd",      "Platform preset for GNU/Hurd")
    map_preset("unix",      "Platform preset for *nix")
    map_preset("m$",        "Diss M!cr0$0f+")
    map_preset("deck", "Platform preset for the Steam Deck")
};

// FIXME: You must follow the order of langs[] in i18n_map[][]
static lang_map langs[] = {
    _LANG("en", "US")
    _LANG("zh", "CN")
    _LANG("zh", "TW")
    _LANG("zh", "HK")
    _LANG("ru", "RU")
    _LANG("ja", "JP")
    _LANG("it", "IT")
    _LANG("fr", "FR")
    _LANG("nl", "NL")
};

// selected language id
static size_t ilang = -1;

// FIXME: You must follow the order of langs[] here
#define platform_preset(platform) \
    {\
        platform_i18n(platform, "en_US", "Activate ",, "Go to Settings to activate ", ".") \
        platform_i18n(platform, "zh_CN", "激活 ",, "转到“设置”以激活 ", "。") \
        platform_i18n(platform, "zh_TW", "啟用 ",, "移至[設定]以啟用 ", "。") \
        platform_i18n(platform, "zh_HK", "啟用 ",, "移至[設定]以啟用 ", "。") \
        platform_i18n(platform, "ru_RU", "Активация ",, "Чтобы активировать ", ",\nперейдите в раздел \"Параметры\".") \
        platform_i18n(platform, "ja_JP",,"のライセンス認証", "設定を開き、", "のライセンス認証を行ってください") \
        platform_i18n(platform, "it_IT", "Attiva ",, "Passa a Impostazioni per attivare ", ".") \
        platform_i18n(platform, "fr_FR", "Activer ",, "Aller en les paramètres pour activer ", ".") \
        platform_i18n(platform, "nl_NL", "Activeren ",, "Gaan naar instellingen om te activeren ", ".")\
    },

// FIXME: You must follow the order of langs[] here
#define ms_diss_preset() \
    { \
        system_i18n ("en_US", "No need to activate ",, "We're not as annoying as Microsoft.") \
        untranslated("zh_CN") \
        untranslated("zh_TW") \
        untranslated("zh_HK") \
        untranslated("ru_RU") \
        untranslated("ja_JP") \
        untranslated("it_IT") \
        untranslated("fr_FR") \
        untranslated("nl_NL") \
    },

// FIXME: You must follow the order of presets[] here
i18n_info i18n_map[][length(langs)] = {
    platform_preset("macOS")      // macOS platform preset
    platform_preset("BSD")        // BSD platform preset
    platform_preset("Linux")      // Linux platform preset
    platform_preset("GNU/Hurd")   // GNU/Hurd platform preset
    platform_preset("*nix")       //  *nix platform preset
    ms_diss_preset()              // ms-diss system preset
    platform_preset("Steam Deck") // Steam Deck platform preset
};

void i18n_set_info(char* preset, struct draw_options* options)
{
    size_t ipreset = DEFAULT_PRESET;

    if (ilang == (size_t)-1) {
        ilang = length(langs);
        char *lang = getenv("LANG");
        while(--ilang && ! match_str(langs[ilang], lang));
    }

    if (preset != NULL) {
        ipreset = length(presets);
        while(--ipreset && ! match_str(presets[ipreset].name, preset));
        if(!match_str(presets[ipreset].name, preset)) {
            __warn__("Undefined preset: %s\n", preset);
            ipreset = DEFAULT_PRESET;
        }
    }

    __info__("Loading preset: %s\n", presets[ipreset].name);
    if (!(PRESET.title && PRESET.subtitle))
        ilang = 0;

    options->title = PRESET.title;
    options->subtitle = PRESET.subtitle;
}

#define HELP(fmtstr, ...) fprintf(stderr, "  " fmtstr "\n", ## __VA_ARGS__)
#define STYLE(x) "\033[" # x "m"
#define END() fprintf(stderr, "\n")
void i18n_list_presets()
{
    fprintf(stderr, "Built-in Presets:\n\n");

    HELP(STYLE(1) "Name\t\tDescription" STYLE(0));
    for(size_t len = 0; len < length(presets); len++ )
        HELP(STYLE(1) "%s"STYLE(0) "\t\t%s", presets[len].name, presets[len].info);
}
#undef END
#undef STYLE
#undef HELP
