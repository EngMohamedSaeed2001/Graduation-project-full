import React, {useContext, useEffect, useState} from "react";
import {BrowserRouter as Router, Route, Routes} from "react-router-dom";
import 'bootstrap/dist/css/bootstrap.min.css';

import './App.css';
import './index.css';

import Footer from "./Component/Footer/Footer";
import Home from "./Component/Home/Home";
import Navs from "./Component/Navbar/Navs";
import ForgetForm from "./Component/Authentication/ForgetPassword/ForgetForm";
import ForgetFormEmail from "./Component/Authentication/ForgetPassword/ForgetFormEmail";
import Wait from "./Component/Authentication/Wait";
import Login from "./Component/Authentication/Login";
import SignUp from "./Component/Authentication/SignUp";
import Error from "./Helper/Error";
import EnterPassword from "./Component/Authentication/ForgetPassword/EnterPassword";
import i18n from '../src/Component/Navbar/i18n';
import Load from "./Helper/Load";
import {ThemeProvider} from "react-bootstrap";
import {Helmet} from "react-helmet";
import LocaleContext from './LocalContext';
import EditProfile from "./Component/Profile/EditProfile";
import Profile from "./Component/Profile/Profile";
import OTP from "./Component/Authentication/OTP";
import Building from "./Component/Building/Building";
import BuildingMenu from "./Component/Building/BuildingMenu";
import Sell from "./Component/Building/Sell";
import Fixed from "./Helper/Fixed";
import ForgetPasswordOTP from "./Component/Authentication/ForgetPassword/ForgetPasswordOTP";
import ForgetPasswordWait from "./Component/Authentication/ForgetPassword/ForgetPasswordWait";
import ChatPage from "./Component/Chat/chat";
import SingleChat from "./Component/Chat/SingleChat";
import {ProtectedLogin} from "./Guard/LoginGuard";
import {UserContext, UserProvider} from "./Context/UserContext";
import {ProtectedUser} from "./Guard/Guard";
import {BuildingProvider} from "./Context/BuildingContext";

///////////////////////////////////////////////////

let token = "";

let login = false

localStorage.getItem("user_token")
if (localStorage.getItem("set_auth") === null) {
    localStorage.setItem("set_auth", "false")

} else if (localStorage.getItem("set_auth") === "true") {
    login = true

}

function App() {
    // let [login,setLogin]=useState(false)



    let ad = localStorage.getItem("ad")

    if (ad === undefined || ad === null || ad === "")
        localStorage.setItem("ad", "true")


    const [locale, setLocale] = useState(i18n.language);
    i18n.on('languageChanged', (lng) => setLocale(i18n.language));

    return (

        <Router>
            <div className="App">
                <LocaleContext.Provider value={{locale, setLocale}}>
                    <React.Suspense fallback={<Load/>}>
                        <Helmet htmlAttributes={{
                            lang: locale,
                            dir: locale === 'en' ? 'ltr' : 'rtl'
                        }}/>
                        <ThemeProvider dir={locale === 'en' ? 'ltr' : 'rtl'}>
                            <Navs login={login}/>
                            {localStorage.getItem("ad") === "true" ? <Fixed/> : ""}
                            <Routes>

                                <Route path='/' element={<UserProvider>
                                        <BuildingProvider>
                                            <Home/>
                                        </BuildingProvider>
                                    </UserProvider>}/>

                                <Route exact path='/signUp' element={<UserProvider><ProtectedLogin/></UserProvider>}>
                                     <Route path='/signUp' element={<SignUp/>}/>
                                </Route>

                                <Route exact path='/login' element={<UserProvider><ProtectedLogin/></UserProvider>}>
                                    <Route path='/login' element={<Login/>}/>
                                </Route>



                                <Route path='/forgetPassword/:otp' element={<ForgetForm/>}/>

                                <Route path='/verifyEmail/:otp' element={<EnterPassword/>}/>

                                <Route path='/otp' element={<UserProvider><OTP/></UserProvider>}/>
                                <Route path='/ForgetPasswordOTP' element={<UserProvider><ForgetPasswordOTP/></UserProvider>}/>

                                <Route path='/resetPassword/' element={<ForgetFormEmail/>}/>
                                <Route path='/wait' element={<Wait/>}/>
                                <Route path='/ForgetPasswordWait' element={<ForgetPasswordWait/>}/>

                                <Route path='/*' element={<Error one={"4"} two={"0"} three={"4"} msg={"Page Not Found"}/>}/>

                                ======================================================
                                <Route exact path='/profile' element={<UserProvider><ProtectedUser/></UserProvider>}>
                                    <Route exact path='/profile' element={<UserProvider><Profile/></UserProvider>}/>
                                </Route>

                                <Route exact path='/editProfile'
                                       element={<UserProvider><ProtectedUser/></UserProvider>}>
                                    <Route exact path='/editProfile'
                                           element={<UserProvider><EditProfile/></UserProvider>}/>
                                </Route>

                                {/*<Route exact path='/profile' element={<ProtectedUser/>}>*/}
                                <Route exact path='/sell' element={<Sell/>}/>
                                {/*</Route>*/}

                                <Route exact path='/buildingMenu/:filter' element={
                                    <UserProvider><BuildingProvider><ProtectedUser/></BuildingProvider></UserProvider>}>
                                    <Route exact path='/buildingMenu/:filter' element={<UserProvider>
                                        <BuildingProvider>
                                            <BuildingMenu/>
                                        </BuildingProvider>
                                    </UserProvider>}/>
                                </Route>


                                <Route exact path='/building/:id' element={<UserProvider>
                                    <BuildingProvider>
                                        <ProtectedUser/>
                                    </BuildingProvider>
                                </UserProvider>}>
                                    <Route exact path='/building/:id' element={<UserProvider>
                                        <BuildingProvider>
                                            <Building/>
                                        </BuildingProvider>
                                    </UserProvider>}/>
                                </Route>

                                <Route exact path='/chat' element={<UserProvider><ProtectedUser/></UserProvider>}>
                                    <Route exact path='/chat' element={<UserProvider><ChatPage/></UserProvider>}/>
                                </Route>

                                <Route exact path='/single-chat/:id/:username' element={<UserProvider><ProtectedUser/></UserProvider>}>
                                    <Route exact path='/single-chat/:id/:username' element={<UserProvider><SingleChat/></UserProvider>}/>
                                </Route>

                                {/*<Route exact path='/map' element={<Map/>}/>*/}
                            </Routes>

                            <Footer/>
                        </ThemeProvider>
                    </React.Suspense>
                </LocaleContext.Provider>


            </div>
        </Router>


    );
}

export default App;