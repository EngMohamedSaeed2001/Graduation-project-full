import React, {useState} from "react";
import '../../index.css';

import {Button, Col, Container, Image, Row} from "react-bootstrap";
import {useTranslation} from "react-i18next";
import api from "../../Apis/Base";


const Wait = () => {
    let {t} = useTranslation()

    let [username, setUsername] = useState("");

    let [done, setDone] = useState(true);
    let [loadButton, setLoadButton] = useState(true);
    let [wait, setWait] = useState(false);
    let [wrong, setWrong] = useState(false);
    let [msg, setMsg] = useState("");

    let email = localStorage.getItem("user_email")

    function sendOTP() {
        api.api.post(`email/sendOtp/${email}`).then((res) => {
            if (res.status === 200) {

            }

        }).catch((e) => {

            setWrong(true)
            setMsg(e.response.data.message)

        })
    }


    return (
        <Container fluid style={{height: "100vh", marginTop: "30px"}}>
            <Container className="wait">

                <Image
                    src={"/images/waiting.png"} width={"100%"}/>

                <h5 style={{color: "#060C43", fontSize: "20px", margin: "40px"}}>
                    {t("codeSent")}
                </h5>

                <Row xs={2} className={"wait-inner"}>
                    <Col>
                        <Button  className={"buttons"} href={"/signup"}>{t("back")}</Button>
                    </Col>
                    <Col>
                        <Button  className={"buttons"} href={'/otp'}
                                onClick={() => {
                                    sendOTP();

                                }}>
                            {t("next")}
                        </Button>
                    </Col>
                </Row>
            </Container>
        </Container>
    );
}

export default Wait;
