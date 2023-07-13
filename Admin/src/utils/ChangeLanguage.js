import React, {useContext, useEffect, useState} from 'react'
import {useTranslation} from 'react-i18next'

import i18n from "./i18n";
import LocaleContext from '../LocalContext';
import {GlobeIcon} from "../icons";

import {  Dropdown, DropdownItem } from '@windmill/react-ui'



export default function ChangeLanguage() {
    const {locale} = useContext(LocaleContext);


  const [isNotificationsMenuOpen, setIsNotificationsMenuOpen] = useState(false)

    // const currentLanguageCode = cookies.get('i18next') || 'en'
    // const currentLanguage = languages.find((l) => l.code === currentLanguageCode)
    const {t} = useTranslation()

    function changeLocale(l) {
        if (locale !== l) {
            i18n.changeLanguage(l).then(r => "");
        }
    }

  function handleNotificationsClick() {
    setIsNotificationsMenuOpen(!isNotificationsMenuOpen)
  }


     useEffect(() => {
        document.title = t('app_title')
    }, [t])

    return (
        <li className="relative">
        <button
              className="relative align-middle rounded-md focus:outline-none focus:shadow-outline-blue"
              onClick={handleNotificationsClick}
              aria-haspopup="true"
            >
              <GlobeIcon className="w-8 h-8" aria-hidden="true" />

            </button>

                <Dropdown
              align="right"
              isOpen={isNotificationsMenuOpen}
              //onClose={() => setIsNotificationsMenuOpen(false)}
            >
              <DropdownItem onClick={() => changeLocale('en')} >
                    English
              </DropdownItem>

              <DropdownItem  onClick={() => changeLocale('ar')}>
                   العربية
              </DropdownItem>

            </Dropdown>
        </li>
    )
}