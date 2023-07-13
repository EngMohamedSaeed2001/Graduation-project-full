import React, {useContext, useEffect, useState} from 'react'
import {SidebarContext} from '../context/SidebarContext'
import {MenuIcon, MoonIcon, SunIcon,} from '../icons'
import {Avatar, WindmillContext} from '@windmill/react-ui'
import ChangeLanguage from "../utils/ChangeLanguage";
import LocaleContext from '../LocalContext';

import {useTranslation} from "react-i18next";

function Header() {

    const {t} = useTranslation()

    const {mode, toggleMode} = useContext(WindmillContext)
    const {toggleSidebar} = useContext(SidebarContext)

    const [isNotificationsMenuOpen, setIsNotificationsMenuOpen] = useState(false)
    const [isProfileMenuOpen, setIsProfileMenuOpen] = useState(false)

    function handleNotificationsClick() {
        setIsNotificationsMenuOpen(!isNotificationsMenuOpen)
    }

    function handleProfileClick() {
        setIsProfileMenuOpen(!isProfileMenuOpen)
    }

    useEffect(() => {

        document.title = t("app_title")

    }, [t])

    return (
        <header className="z-40 py-4 bg-white shadow-bottom dark:bg-gray-800">
            <div
                className="container flex items-center justify-between h-full px-6 mx-auto text-blue-600 dark:text-blue-300">
                {/* <!-- Mobile hamburger --> */}
                <button
                    className="p-1 mr-5 -ml-1 rounded-md lg:hidden focus:outline-none focus:shadow-outline-blue"
                    onClick={toggleSidebar}
                    aria-label="Menu"
                >
                    <MenuIcon className="w-6 h-6" aria-hidden="true"/>
                </button>
                {/* <!-- Search input --> */}
                <div className="flex justify-center flex-1 lg:mr-32">

                </div>
                <ul className="flex items-center flex-shrink-0 space-x-6">
                    {/* <!-- Theme toggler --> */}
                    <li className="flex">
                        <button
                            className="rounded-md focus:outline-none focus:shadow-outline-blue"
                            onClick={toggleMode}
                            aria-label="Toggle color mode"
                        >
                            {mode === 'dark' ? (
                                <SunIcon className="w-5 h-5" aria-hidden="true"/>
                            ) : (
                                <MoonIcon className="w-5 h-5" aria-hidden="true"/>
                            )}
                        </button>
                    </li>

                        <ChangeLanguage/>

                    {/* <!-- Notifications menu --> */}
                    <li className="relative">
                        <p>{t("welcome")} Admin</p>
                    </li>
                    {/* <!-- Profile menu --> */}
                    <li className="relative">
                        <Avatar
                            className="align-middle"
                            src="/static/images/avatars/admin.png"
                            alt=""
                            aria-hidden="true"
                        />
                    </li>
                </ul>
            </div>
        </header>
    )
}

export default Header
