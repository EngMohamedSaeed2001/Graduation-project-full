import React, {lazy, useState} from 'react'
import LocaleContext from './LocalContext';

import {BrowserRouter as Router, Redirect, Route, Switch} from 'react-router-dom'
import AccessibleNavigationAnnouncer from './components/AccessibleNavigationAnnouncer'
import i18n from "../src/utils/i18n";

const Layout = lazy(() => import('./containers/Layout'))
const Login = lazy(() => import('./pages/Login'))
const ForgotPassword = lazy(() => import('./pages/ForgotPassword'))

function App() {
    const [locale, setLocale] = useState(i18n.language);
    i18n.on('languageChanged', (lng) => setLocale(i18n.language));
    return (
        <>
            <Router>
                <LocaleContext.Provider value={{locale, setLocale}}>
                <AccessibleNavigationAnnouncer/>
                <Switch>
                    <Route path="/login" component={Login}/>
                    <Route path="/forgot-password" component={ForgotPassword}/>

                     {/*<Route exact path='/app' element={<ProtectedUser/>}>*/}

                    {/* Place new routes over this */}
                    <Route path="/app" component={Layout}/>

                     {/*</Route>*/}

                    {/* If you have an index page, you can remothis Redirect */}
                    <Redirect exact from="/" to="/login"/>
                </Switch>
                </LocaleContext.Provider>
            </Router>
        </>
    )
}

export default App
