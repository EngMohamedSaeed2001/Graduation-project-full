import React from 'react'

import {ForbiddenIcon} from '../icons'
import {useTranslation} from "react-i18next";

function Page404() {
    const {t} = useTranslation()
    return (
        <div className="flex flex-col items-center">
            <ForbiddenIcon className="w-12 h-12 mt-8 text-blue-200" aria-hidden="true"/>
            <h1 className="text-6xl font-semibold text-gray-700 dark:text-gray-200">404</h1>
            <p className="text-gray-700 dark:text-gray-300">
                Page not found. Check the address or{' '}
                <a className="text-blue-600 hover:underline dark:text-blue-300" href="../index.html">
                    {t("back")}
                </a>
                .
            </p>
        </div>
    )
}

export default Page404
