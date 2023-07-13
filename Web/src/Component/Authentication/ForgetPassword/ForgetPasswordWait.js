import React, {useState} from "react";
import '../../../index.css';

import {Button, Col, Container, Image, Row} from "react-bootstrap";
import {useTranslation} from "react-i18next";
import api from "../../../Apis/Base";


const ForgetPasswordWait = () => {
    let {t} = useTranslation()

    let [username, setUsername] = useState("");

    let [done, setDone] = useState(true);
    let [loadButton, setLoadButton] = useState(true);
    let [wait, setWait] = useState(false);
    let [wrong, setWrong] = useState(false);
    let [msg, setMsg] = useState("");

    let email = localStorage.getItem("user_email")

    const send = () => {
        api.api.post("forgetPassword/", {
            email: email,
        }).then((res) => {
            if (res.status === 201) {

                setWait(true);
                setLoadButton(true)
            }

        }).catch((e) => {

            console.log(e.response.data.message)
            setWrong(true)
            setMsg(e.response.data.message)
            setLoadButton(true)
        })

    }

    //   if (wait) {
    //
    //     setTimeout(() => {
    //         setLoadButton(true)
    //     }, 1000)
    //     return <Navigate to={'/ForgetPasswordOTP'}/>
    // }


    return (
        <Container fluid style={{height: "100vh", marginTop: "30px"}}>
            <Container className="wait">

                <Image
                    src={"/images/waiting.png"} width={"100%"}/>

                <h5 style={{color: "#060C43", fontSize: "20px", margin: "40px"}}>
                    {t("codeSent")}
                </h5>

                <Row style={{margin: "40px"}}>
                    <Col>
                        <Button className={"buttons"} href={"/resetPassword/"}>{t("back")}</Button>
                    </Col>
                    <Col>
                        <Button className={"buttons"} href={"/ForgetPasswordOTP"}
                                onClick={() => {
                                    send();

                                }}>
                            {t("next")}
                        </Button>
                    </Col>
                </Row>
            </Container>
        </Container>
    );
}

export default ForgetPasswordWait;
