#ifndef I18N
#define I18N
typedef struct{
    char *title, *subtitle;
}i18n_info;
i18n_info i18n_get_info(char *system_name);
void i18n_info_destroy(i18n_info *i18n);
#endif