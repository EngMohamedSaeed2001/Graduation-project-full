import React, {useState} from 'react'
import {Link, Redirect} from 'react-router-dom'
import ImageLight from '../assets/img/login-office.jpeg'
import ImageDark from '../assets/img/login-office-dark.jpeg'
import {Alert, Button, Input, Label} from '@windmill/react-ui'
import {useTranslation} from "react-i18next";
import Api from '../utils/Base'
import {Spinner} from "react-bootstrap";

function Login() {
    const {t} = useTranslation()
    let [email, setEmail] = useState("");
    let [password, setPassword] = useState("");
    let [msg, setMsg] = useState("");
    let [waits, setWait] = useState(false);
    let [wrong, setWrong] = useState(false);
    let [load, setLoad] = useState(false);

    function submit() {
        Api.api.post("insecure/authenticate", {
            email: email,
            password: password,
            social: false

        }).then((res) => {
            if (res.status === 200) {
                setEmail("")
                setPassword("")

                localStorage.setItem("admin_token", res.data.token)
                localStorage.setItem("admin_auth", "true")

                setWait(true)


            }

        }).catch((e) => {

            console.log(e.response.data.message)
            setWrong(true)
            setMsg(e.response.data.message)
            setLoad(true)
        })
    }

    if(waits){
        return <Redirect to='/app'/>;
    }

    return (
        <div className="flex items-center min-h-screen p-6 bg-gray-50 dark:bg-gray-900">
            <div
                className="flex-1 h-full max-w-4xl mx-auto overflow-hidden bg-white rounded-lg shadow-xl dark:bg-gray-800">
                <div className="flex flex-col overflow-y-auto md:flex-row">

                    <div className="h-32 md:h-auto md:w-1/2">
                        <img
                            aria-hidden="true"
                            className="object-cover w-full h-full dark:hidden"
                            src={ImageLight}
                            alt="Office"
                        />
                        <img
                            aria-hidden="true"
                            className="hidden object-cover w-full h-full dark:block"
                            src={ImageDark}
                            alt="Office"
                        />
                    </div>
                    <main className="flex items-center justify-center p-6 sm:p-12 md:w-1/2">
                        <div className="w-full">
                            <h1 className="mb-4 text-xl font-semibold text-gray-700 dark:text-gray-200">{t("login")}</h1>
                            <Label>
                                <span>{t('email')}</span>
                                <Input className="mt-1" type="email" value={email}
                                       onChange={(e) => setEmail(e.target.value)} placeholder="john@doe.com"/>
                            </Label>

                            <Label className="mt-4">
                                <span>{t("Password")}</span>
                                <Input className="mt-1" type="password" value={password}
                                       onChange={(e) => setPassword(e.target.value)} placeholder="***************"/>
                            </Label>

                            <Button className="mt-4" block onClick={() => {
                                submit();
                                setLoad(true);

                            }
                            }>
                                {t("login")}
                            </Button>


                        </div>
                    </main>
                </div>
            </div>
        </div>
    )
}

export default Login
